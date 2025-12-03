# https://oklch.com
lib: math: let
  convertLchToLab = {
    l ? 0,
    c ? 0,
    h ? 0,
  }: {
    inherit l;
    a = c * (math.cos ((h / 180) * math.pi));
    b = c * (math.sin ((h / 180) * math.pi));
  };

  rgbLinearInterpolator = {
    r ? 0,
    g ? 0,
    b ? 0,
  }: let
    lerp = a: b: t: a + t * (b - a);
    clamp = min: max: value:
      if value < min
      then min
      else if value > max
      then max
      else value;
    interpolate = _: t: lerp 0 255 (clamp 0 1 t);
  in
    lib.attrsets.mapAttrs interpolate {inherit r g b;};

  convertOklabToLrgb = {
    l ? 0,
    a ? 0,
    b ? 0,
  }: let
    L = math.pow (l + 0.3963377773761749 * a + 0.2158037573099136 * b) 3;
    M = math.pow (l - 0.1055613458156586 * a - 0.0638541728258133 * b) 3;
    S = math.pow (l - 0.0894841775298119 * a - 1.2914855480194092 * b) 3;
  in {
    r = 4.0767416360759574 * L - 3.3077115392580616 * M + 0.2309699031821044 * S;
    g = -1.2684379732850317 * L + 2.6097573492876887 * M - 0.3413193760026573 * S;
    b = -0.0041960761386756 * L - 0.7034186179359362 * M + 1.7076146940746117 * S;
  };

  convertLrgbToRgb = rgb: let
    sign = value:
      if value < 0
      then -1
      else 1;

    fn = _: value: let
      abs = math.abs value;
    in
      if abs > 0.0031308
      then (sign value) * (1.055 * (math.pow abs (1 / 2.4)) - 0.055)
      else value * 12.92;
  in
    lib.attrsets.mapAttrs fn rgb;

  convertOklchToRgb = lch: convertLrgbToRgb (convertOklabToLrgb (convertLchToLab lch));

  rgbToHex = rgb: let
    toHex = value: let
      rounded = math.round value;
    in
      if rounded < 16
      then "0${lib.trivial.toHexString rounded}"
      else lib.trivial.toHexString rounded;
  in
    lib.concatStrings (builtins.map toHex (with (rgbLinearInterpolator rgb); [r g b]));

  palette = let
    _ = l: c: h: {inherit l c h;};
  in {
    tailwind = {
      red-50 = _ 0.971 0.013 17.38;
      red-100 = _ 0.936 0.032 17.717;
      red-200 = _ 0.885 0.062 18.334;
      red-300 = _ 0.808 0.114 19.571;
      red-400 = _ 0.704 0.191 22.216;
      red-500 = _ 0.637 0.237 25.331;
      red-600 = _ 0.577 0.245 27.325;
      red-700 = _ 0.505 0.213 27.518;
      red-800 = _ 0.444 0.177 26.899;
      red-900 = _ 0.396 0.141 25.723;
      red-950 = _ 0.258 0.092 26.042;
      orange-50 = _ 0.98 0.016 73.684;
      orange-100 = _ 0.954 0.038 75.164;
      orange-200 = _ 0.901 0.076 70.697;
      orange-300 = _ 0.837 0.128 66.29;
      orange-400 = _ 0.75 0.183 55.934;
      orange-500 = _ 0.705 0.213 47.604;
      orange-600 = _ 0.646 0.222 41.116;
      orange-700 = _ 0.553 0.195 38.402;
      orange-800 = _ 0.47 0.157 37.304;
      orange-900 = _ 0.408 0.123 38.172;
      orange-950 = _ 0.266 0.079 36.259;
      amber-50 = _ 0.987 0.022 95.277;
      amber-100 = _ 0.962 0.059 95.617;
      amber-200 = _ 0.924 0.12 95.746;
      amber-300 = _ 0.879 0.169 91.605;
      amber-400 = _ 0.828 0.189 84.429;
      amber-500 = _ 0.769 0.188 70.08;
      amber-600 = _ 0.666 0.179 58.318;
      amber-700 = _ 0.555 0.163 48.998;
      amber-800 = _ 0.473 0.137 46.201;
      amber-900 = _ 0.414 0.112 45.904;
      amber-950 = _ 0.279 0.077 45.635;
      yellow-50 = _ 0.987 0.026 102.212;
      yellow-100 = _ 0.973 0.071 103.193;
      yellow-200 = _ 0.945 0.129 101.54;
      yellow-300 = _ 0.905 0.182 98.111;
      yellow-400 = _ 0.852 0.199 91.936;
      yellow-500 = _ 0.795 0.184 86.047;
      yellow-600 = _ 0.681 0.162 75.834;
      yellow-700 = _ 0.554 0.135 66.442;
      yellow-800 = _ 0.476 0.114 61.907;
      yellow-900 = _ 0.421 0.095 57.708;
      yellow-950 = _ 0.286 0.066 53.813;
      lime-50 = _ 0.986 0.031 120.757;
      lime-100 = _ 0.967 0.067 122.328;
      lime-200 = _ 0.938 0.127 124.321;
      lime-300 = _ 0.897 0.196 126.665;
      lime-400 = _ 0.841 0.238 128.85;
      lime-500 = _ 0.768 0.233 130.85;
      lime-600 = _ 0.648 0.2 131.684;
      lime-700 = _ 0.532 0.157 131.589;
      lime-800 = _ 0.453 0.124 130.933;
      lime-900 = _ 0.405 0.101 131.063;
      lime-950 = _ 0.274 0.072 132.109;
      green-50 = _ 0.982 0.018 155.826;
      green-100 = _ 0.962 0.044 156.743;
      green-200 = _ 0.925 0.084 155.995;
      green-300 = _ 0.871 0.15 154.449;
      green-400 = _ 0.792 0.209 151.711;
      green-500 = _ 0.723 0.219 149.579;
      green-600 = _ 0.627 0.194 149.214;
      green-700 = _ 0.527 0.154 150.069;
      green-800 = _ 0.448 0.119 151.328;
      green-900 = _ 0.393 0.095 152.535;
      green-950 = _ 0.266 0.065 152.934;
      emerald-50 = _ 0.979 0.021 166.113;
      emerald-100 = _ 0.95 0.052 163.051;
      emerald-200 = _ 0.905 0.093 164.15;
      emerald-300 = _ 0.845 0.143 164.978;
      emerald-400 = _ 0.765 0.177 163.223;
      emerald-500 = _ 0.696 0.17 162.48;
      emerald-600 = _ 0.596 0.145 163.225;
      emerald-700 = _ 0.508 0.118 165.612;
      emerald-800 = _ 0.432 0.095 166.913;
      emerald-900 = _ 0.378 0.077 168.94;
      emerald-950 = _ 0.262 0.051 172.552;
      teal-50 = _ 0.984 0.014 180.72;
      teal-100 = _ 0.953 0.051 180.801;
      teal-200 = _ 0.91 0.096 180.426;
      teal-300 = _ 0.855 0.138 181.071;
      teal-400 = _ 0.777 0.152 181.912;
      teal-500 = _ 0.704 0.14 182.503;
      teal-600 = _ 0.60 0.118 184.704;
      teal-700 = _ 0.511 0.096 186.391;
      teal-800 = _ 0.437 0.078 188.216;
      teal-900 = _ 0.386 0.063 188.416;
      teal-950 = _ 0.277 0.046 192.524;
      cyan-50 = _ 0.984 0.019 200.873;
      cyan-100 = _ 0.956 0.045 203.388;
      cyan-200 = _ 0.917 0.08 205.041;
      cyan-300 = _ 0.865 0.127 207.078;
      cyan-400 = _ 0.789 0.154 211.53;
      cyan-500 = _ 0.715 0.143 215.221;
      cyan-600 = _ 0.609 0.126 221.723;
      cyan-700 = _ 0.52 0.105 223.128;
      cyan-800 = _ 0.45 0.085 224.283;
      cyan-900 = _ 0.398 0.07 227.392;
      cyan-950 = _ 0.302 0.056 229.695;
      sky-50 = _ 0.977 0.013 236.62;
      sky-100 = _ 0.951 0.026 236.824;
      sky-200 = _ 0.901 0.058 230.902;
      sky-300 = _ 0.828 0.111 230.318;
      sky-400 = _ 0.746 0.16 232.661;
      sky-500 = _ 0.685 0.169 237.323;
      sky-600 = _ 0.588 0.158 241.966;
      sky-700 = _ 0.50 0.134 242.749;
      sky-800 = _ 0.443 0.11 240.79;
      sky-900 = _ 0.391 0.09 240.876;
      sky-950 = _ 0.293 0.066 243.157;
      blue-50 = _ 0.97 0.014 254.604;
      blue-100 = _ 0.932 0.032 255.585;
      blue-200 = _ 0.882 0.059 254.128;
      blue-300 = _ 0.809 0.105 251.813;
      blue-400 = _ 0.707 0.165 254.624;
      blue-500 = _ 0.623 0.214 259.815;
      blue-600 = _ 0.546 0.245 262.881;
      blue-700 = _ 0.488 0.243 264.376;
      blue-800 = _ 0.424 0.199 265.638;
      blue-900 = _ 0.379 0.146 265.522;
      blue-950 = _ 0.282 0.091 267.935;
      indigo-50 = _ 0.962 0.018 272.314;
      indigo-100 = _ 0.93 0.034 272.788;
      indigo-200 = _ 0.87 0.065 274.039;
      indigo-300 = _ 0.785 0.115 274.713;
      indigo-400 = _ 0.673 0.182 276.935;
      indigo-500 = _ 0.585 0.233 277.117;
      indigo-600 = _ 0.511 0.262 276.966;
      indigo-700 = _ 0.457 0.24 277.023;
      indigo-800 = _ 0.398 0.195 277.366;
      indigo-900 = _ 0.359 0.144 278.697;
      indigo-950 = _ 0.257 0.09 281.288;
      violet-50 = _ 0.969 0.016 293.756;
      violet-100 = _ 0.943 0.029 294.588;
      violet-200 = _ 0.894 0.057 293.283;
      violet-300 = _ 0.811 0.111 293.571;
      violet-400 = _ 0.702 0.183 293.541;
      violet-500 = _ 0.606 0.25 292.717;
      violet-600 = _ 0.541 0.281 293.009;
      violet-700 = _ 0.491 0.27 292.581;
      violet-800 = _ 0.432 0.232 292.759;
      violet-900 = _ 0.38 0.189 293.745;
      violet-950 = _ 0.283 0.141 291.089;
      purple-50 = _ 0.977 0.014 308.299;
      purple-100 = _ 0.946 0.033 307.174;
      purple-200 = _ 0.902 0.063 306.703;
      purple-300 = _ 0.827 0.119 306.383;
      purple-400 = _ 0.714 0.203 305.504;
      purple-500 = _ 0.627 0.265 303.9;
      purple-600 = _ 0.558 0.288 302.321;
      purple-700 = _ 0.496 0.265 301.924;
      purple-800 = _ 0.438 0.218 303.724;
      purple-900 = _ 0.381 0.176 304.987;
      purple-950 = _ 0.291 0.149 302.717;
      fuchsia-50 = _ 0.977 0.017 320.058;
      fuchsia-100 = _ 0.952 0.037 318.852;
      fuchsia-200 = _ 0.903 0.076 319.62;
      fuchsia-300 = _ 0.833 0.145 321.434;
      fuchsia-400 = _ 0.74 0.238 322.16;
      fuchsia-500 = _ 0.667 0.295 322.15;
      fuchsia-600 = _ 0.591 0.293 322.896;
      fuchsia-700 = _ 0.518 0.253 323.949;
      fuchsia-800 = _ 0.452 0.211 324.591;
      fuchsia-900 = _ 0.401 0.17 325.612;
      fuchsia-950 = _ 0.293 0.136 325.661;
      pink-50 = _ 0.971 0.014 343.198;
      pink-100 = _ 0.948 0.028 342.258;
      pink-200 = _ 0.899 0.061 343.231;
      pink-300 = _ 0.823 0.12 346.018;
      pink-400 = _ 0.718 0.202 349.761;
      pink-500 = _ 0.656 0.241 354.308;
      pink-600 = _ 0.592 0.249 0.584;
      pink-700 = _ 0.525 0.223 3.958;
      pink-800 = _ 0.459 0.187 3.815;
      pink-900 = _ 0.408 0.153 2.432;
      pink-950 = _ 0.284 0.109 3.907;
      rose-50 = _ 0.969 0.015 12.422;
      rose-100 = _ 0.941 0.03 12.58;
      rose-200 = _ 0.892 0.058 10.001;
      rose-300 = _ 0.81 0.117 11.638;
      rose-400 = _ 0.712 0.194 13.428;
      rose-500 = _ 0.645 0.246 16.439;
      rose-600 = _ 0.586 0.253 17.585;
      rose-700 = _ 0.514 0.222 16.935;
      rose-800 = _ 0.455 0.188 13.697;
      rose-900 = _ 0.41 0.159 10.272;
      rose-950 = _ 0.271 0.105 12.094;
      slate-50 = _ 0.984 0.003 247.858;
      slate-100 = _ 0.968 0.007 247.896;
      slate-200 = _ 0.929 0.013 255.508;
      slate-300 = _ 0.869 0.022 252.894;
      slate-400 = _ 0.704 0.04 256.788;
      slate-500 = _ 0.554 0.046 257.417;
      slate-600 = _ 0.446 0.043 257.281;
      slate-700 = _ 0.372 0.044 257.287;
      slate-800 = _ 0.279 0.041 260.031;
      slate-900 = _ 0.208 0.042 265.755;
      slate-950 = _ 0.129 0.042 264.695;
      gray-50 = _ 0.985 0.002 247.839;
      gray-100 = _ 0.967 0.003 264.542;
      gray-200 = _ 0.928 0.006 264.531;
      gray-300 = _ 0.872 0.01 258.338;
      gray-400 = _ 0.707 0.022 261.325;
      gray-500 = _ 0.551 0.027 264.364;
      gray-600 = _ 0.446 0.03 256.802;
      gray-700 = _ 0.373 0.034 259.733;
      gray-800 = _ 0.278 0.033 256.848;
      gray-900 = _ 0.21 0.034 264.665;
      gray-950 = _ 0.13 0.028 261.692;
      zinc-50 = _ 0.985 0 0;
      zinc-100 = _ 0.967 0.001 286.375;
      zinc-200 = _ 0.92 0.004 286.32;
      zinc-300 = _ 0.871 0.006 286.286;
      zinc-400 = _ 0.705 0.015 286.067;
      zinc-500 = _ 0.552 0.016 285.938;
      zinc-600 = _ 0.442 0.017 285.786;
      zinc-700 = _ 0.37 0.013 285.805;
      zinc-800 = _ 0.274 0.006 286.033;
      zinc-900 = _ 0.21 0.006 285.885;
      zinc-950 = _ 0.141 0.005 285.823;
      neutral-50 = _ 0.985 0 0;
      neutral-100 = _ 0.97 0 0;
      neutral-200 = _ 0.922 0 0;
      neutral-300 = _ 0.87 0 0;
      neutral-400 = _ 0.708 0 0;
      neutral-500 = _ 0.556 0 0;
      neutral-600 = _ 0.439 0 0;
      neutral-700 = _ 0.371 0 0;
      neutral-800 = _ 0.269 0 0;
      neutral-900 = _ 0.205 0 0;
      neutral-950 = _ 0.145 0 0;
      stone-50 = _ 0.985 0.001 106.423;
      stone-100 = _ 0.97 0.001 106.424;
      stone-200 = _ 0.923 0.003 48.717;
      stone-300 = _ 0.869 0.005 56.366;
      stone-400 = _ 0.709 0.01 56.259;
      stone-500 = _ 0.553 0.013 58.071;
      stone-600 = _ 0.444 0.011 73.639;
      stone-700 = _ 0.374 0.01 67.558;
      stone-800 = _ 0.268 0.007 34.298;
      stone-900 = _ 0.216 0.006 56.043;
      stone-950 = _ 0.147 0.004 49.25;
    };

    # Blends calculated via browser compositing (as opposed to uniform interpolation).
    blends = {
      surface = _ 0.1921 0.0213 267.51; # gray-950 + white/5 = #10141E
      surface_lighter = _ 0.2435 0.0182 266.22; # surface0 + white/5 = #1C2029
      surface_lightest = _ 0.2899 0.017 270.77; # surface1 + white/5 = #282B34

      surface_variant = _ 0.1923 0.035 272.67; # slate-950 + white/5 = #0F1324
      surface_variant_lighter = _ 0.2432 0.0312 273.09; # surface_variant0 + white/5 = #1B1F2F

      surface_amber = _ 0.3114 0.0272 98.78; # surface + amber-300/15 = #343121
      surface_blue = _ 0.3027 0.0367 258.31; # surface + blue-300/15 = #232F41
      surface_green = _ 0.3105 0.0271 188.31; # surface + green-300/15 = #203533
      surface_red = _ 0.2981 0.0235 335.14; # surface + red-300/15 = #352932
      surface_violet = _ 0.3019 0.0378 281.76; # surface + violet-300/15 = #2B2C41
    };

    others = {
      magenta = _ 0.7017 0.3225 328.36; # #ff00ff
    };
  };

  theme = with palette; rec {
    text = tailwind.slate-300;
    text_dim = tailwind.slate-400;
    text_dimmer = tailwind.slate-500;
    text_dimmest = tailwind.slate-600;
    text_conceal = tailwind.slate-700;

    text_variant = tailwind.gray-300;
    text_variant_dim = tailwind.gray-400;
    text_variant_dimmer = tailwind.gray-500;
    text_variant_dimmest = tailwind.gray-600;
    text_variant_conceal = tailwind.gray-700;

    text_red = tailwind.red-200;
    text_orange = tailwind.orange-100;
    text_amber = tailwind.amber-100;
    text_yellow = tailwind.yellow-50;
    text_lime = tailwind.lime-200;
    text_green = tailwind.green-200;
    text_emerald = tailwind.emerald-200;
    text_teal = tailwind.teal-300;
    text_cyan = tailwind.cyan-200;
    text_sky = tailwind.sky-300;
    text_blue = tailwind.blue-300;
    text_indigo = tailwind.indigo-200;
    text_violet = tailwind.violet-200;
    text_purple = tailwind.purple-200;
    text_fuchsia = tailwind.fuchsia-200;
    text_pink = tailwind.pink-200;
    text_rose = tailwind.rose-200;

    text_title = tailwind.slate-100;
    text_link = tailwind.blue-300;
    text_function = tailwind.blue-300;

    text_ok = tailwind.green-200;
    text_error = tailwind.red-200;
    text_warning = tailwind.amber-100;
    text_info = tailwind.blue-300;
    text_hint = tailwind.indigo-300;

    borders = tailwind.slate-500;

    surface_dark = tailwind.gray-950;
    surface = blends.surface;
    surface_cursorline = blends.surface_lighter;
    surface_statusline = blends.surface_lighter;
    surface_menu = blends.surface_lighter;
    surface_menu_cursorline = blends.surface_lightest;

    surface_scrollbar = blends.surface_variant;
    surface_scrollbar_thumb = blends.surface_variant_lighter;

    surface_visual = tailwind.blue-800;
    on_surface_visual = tailwind.blue-50;

    surface_red = blends.surface_red;
    on_surface_red = tailwind.red-200;

    surface_green = blends.surface_green;
    on_surface_green = tailwind.green-200;

    surface_amber = blends.surface_amber;
    on_surface_amber = tailwind.amber-100;

    surface_blue = blends.surface_blue;
    on_surface_blue = tailwind.blue-300;

    surface_violet = blends.surface_violet;
    on_surface_violet = tailwind.violet-200;

    UNUSED = others.magenta;

    terminal_color_0 = surface;
    terminal_color_8 = surface_menu;

    terminal_color_1 = text_red;
    terminal_color_9 = text_orange;

    terminal_color_2 = text_green;
    terminal_color_10 = text_emerald;

    terminal_color_3 = text_amber;
    terminal_color_11 = text_yellow;

    terminal_color_4 = text_blue;
    terminal_color_12 = text_sky;

    terminal_color_13 = text_teal;
    terminal_color_5 = text_cyan;

    terminal_color_6 = text_indigo;
    terminal_color_14 = text_violet;

    terminal_color_7 = text;
    terminal_color_15 = text_dim;
  };
in {
  inherit convertOklchToRgb rgbToHex;
  inherit palette theme;
}
