{ pkgs }:

plugins: moduleName:

let
  # Default order if not specified
  addDefaultOrder = p: p // { order = p.order or 1000; };

  sortedPlugins = builtins.sort
    (
      a: b: a.order < b.order
    )
    (map addDefaultOrder plugins);

  runtimeDeps = builtins.concatLists (map (p: p.dependencies or [ ]) sortedPlugins);

  runtimePath = pkgs.symlinkJoin {
    name = "nvim-plugins-runtime";
    paths = runtimeDeps;
  };

  neovimPlugins = builtins.concatLists (map (p: p.plugins or [ ]) sortedPlugins);

  configDir = pkgs.runCommand "nvim-plugin-configs" { } (
    let
      writeOne = p: ''
                mkdir -p $out/lua/${moduleName}
                cat > $out/lua/${moduleName}/${p.name}.lua << 'EOF'
        ${p.config or ""}
        EOF'';
    in
    builtins.concatStringsSep "\n" (map writeOne sortedPlugins)
  );

  requireLines = builtins.concatStringsSep "\n" (
    map (p: ''require("${moduleName}.${p.name}")'') sortedPlugins
  );

in
{
  inherit neovimPlugins runtimePath configDir requireLines;
}
