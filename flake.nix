{
	description = "hollowillow system configuration";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		# home-manager = {
		# 	url = "github:nix-community/home-manager";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
	};
	outputs = { nixpkgs, home-manager, ... }:
		let 
				system = "x86_64-linux";
		in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
				./hosts/nixos/configuration.nix
				./modules/bundle.nix
			];
		};
		# homeConfigurations.hollowillow = home-manager.lib.homeManagerConfiguration {
		# 	pkgs = nixpkgs.legacyPackages.${system};
		# 	modules = [ ./home.nix ];
		# };
	};
}
