{ pkgs, lib, config, ... }: {

	options = {
		modules.proxy.enable = lib.mkEnableOption "Enables proxy module";
	};

	config = lib.mkIf config.modules.proxy.enable {
		networking = {
			proxy = {
				default = "http://user:password@proxt:port/";
				noProxy = "127.0.0.1,localhost,internal.domain";
			};
		};
	};

}
