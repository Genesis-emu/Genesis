import Foundation
extension PVRetroArchCore: CoreOptional {
    static var gsOption: CoreOption = {
         .enumeration(.init(title: "Graphics Handler",
               description: "(Requires Restart)",
               requiresRestart: true),
          values: [
               .init(title: "Metal", description: "Metal", value: 0),
               .init(title: "OpenGL", description: "OpenGL", value: 1),
               .init(title: "Vulkan", description: "Vulkan", value: 2)
          ],
          defaultValue: 0)
    }()
    static var retroArchControlOption: CoreOption = {
        .bool(.init(
            title: USE_RETROARCH_CONTROLLER,
            description: nil,
            requiresRestart: false),
              defaultValue: false)
    }()
    static var secondScreenOption: CoreOption = {
        .bool(.init(
            title: USE_SECOND_SCREEN,
            description: nil,
            requiresRestart: false),
              defaultValue: false)
    }()
    static var analogKeyControlOption: CoreOption = {
        .bool(.init(
            title: ENABLE_ANALOG_KEY,
            description: nil,
            requiresRestart: false),
              defaultValue: (PVRetroArchCore.systemName.contains("dos")  ||
                             PVRetroArchCore.systemName.contains("mac")  ||
                             PVRetroArchCore.systemName.contains("pc98")) ? false : true)
    }()
    static var numKeyControlOption: CoreOption = {
        .bool(.init(
            title: ENABLE_NUM_KEY,
            description: nil,
            requiresRestart: false),
              defaultValue: false)
    }()
    static var analogDpadControlOption: CoreOption = {
        .bool(.init(
            title: ENABLE_ANALOG_DPAD,
            description: nil,
            requiresRestart: false),
              defaultValue: true)
    }()
    //
    
    static var mupenRDPOption: CoreOption = {
          .enumeration(.init(title: "Mupen RDP Plugin",
               description: "(Requires Restart)",
               requiresRestart: true),
          values: [
               .init(title: "Angrylion", description: "Angrylion", value: 0),
               .init(title: "GlideN64", description: "GlideN64", value: 1)
          ],
          defaultValue: 1)
    }()
    static var volumeOption: CoreOption = {
        .enumeration(.init(title: "Audio Volume",
                           description: "",
                           requiresRestart: false),
                     values: [
                        .init(title: "100%", description: "100%", value: 100),
                        .init(title: "90%", description: "90%", value: 90),
                        .init(title: "80%", description: "80%", value: 80),
                        .init(title: "70%", description: "70%", value: 70),
                        .init(title: "60%", description: "60%", value: 60),
                        .init(title: "50%", description: "50%", value: 50),
                        .init(title: "40%", description: "40%", value: 40),
                        .init(title: "30%", description: "30%", value: 30),
                        .init(title: "20%", description: "20%", value: 20),
                        .init(title: "10%", description: "10%", value: 10),
                        .init(title: "0%", description: "0%", value: 0),
                     ],
                     defaultValue: 80)
    }()
    //
    public static var options: [CoreOption] {
        var options = [CoreOption]()
        var coreOptions: [CoreOption] = [gsOption]
        
        coreOptions.append(retroArchControlOption)
        if (self.className.contains("mupen")) {
            coreOptions.append(mupenRDPOption)
        }
        if (self.systemName.contains("psx") ||
            self.systemName.contains("dreamcast") ||
            self.systemName.contains("saturn")
        ) {
            coreOptions.append(analogDpadControlOption)
        }
        coreOptions.append(analogKeyControlOption)
        if (self.systemName.contains("retroarch") ||
             self.systemName.contains("dos") ||
             self.systemName.contains("mac") ||
             self.systemName.contains("pc98")) {
            coreOptions.append(numKeyControlOption)
        }
        if (UIScreen.screens.count > 1 && UIDevice.current.userInterfaceIdiom == .pad) {
            coreOptions.append(secondScreenOption)
        }
        coreOptions.append(volumeOption)
        let coreGroup:CoreOption = .group(.init(title: "RetroArch Core",
                                                description: "Override options for RetroArch Core"),
                                          subOptions: coreOptions)
        options.append(contentsOf: [coreGroup])
        return options
    }
}

@objc public extension PVRetroArchCore {
    @objc var gs: Int {
        PVRetroArchCore.valueForOption(PVRetroArchCore.gsOption).asInt ?? 0
    }
    @objc var retroControl: Bool {
        PVRetroArchCore.valueForOption(PVRetroArchCore.retroArchControlOption).asBool
    }
    @objc var secondScreen: Bool {
        PVRetroArchCore.valueForOption(PVRetroArchCore.secondScreenOption).asBool
    }
    @objc func parseOptions() {
        var optionValues:String = ""
        var optionValuesFile: String = ""
        var optionOverwrite: Bool = false
        self.gsPreference = NSNumber(value: gs).int8Value
        self.volume = NSNumber(value: PVRetroArchCore.valueForOption(PVRetroArchCore.volumeOption).asInt ?? 100).int8Value
        self.bindAnalogKeys = PVRetroArchCore.valueForOption(PVRetroArchCore.analogKeyControlOption).asBool
        self.bindNumKeys = PVRetroArchCore.valueForOption(PVRetroArchCore.numKeyControlOption).asBool
        self.bindAnalogDpad = PVRetroArchCore.valueForOption(PVRetroArchCore.analogDpadControlOption).asBool
        self.retroArchControls = true
        self.hasTouchControls=false
        self.extractArchive=true
        if (UIScreen.screens.count > 1 && UIDevice.current.userInterfaceIdiom == .pad) {
            self.hasSecondScreen = secondScreen;
        }
        if (self.systemIdentifier != nil) {
            if (self.systemIdentifier!.contains("psp")) {
                self.gsPreference = 2; // Use Vulkan PSP
            }
            if (self.systemIdentifier!.contains("snes") ||
                self.systemIdentifier!.contains("nes")  ||
                self.systemIdentifier!.contains("dreamcast")  ||
                self.systemIdentifier!.contains("genesis")  ||
                self.systemIdentifier!.contains("saturn")  ||
                self.systemIdentifier!.contains("3DO")  ||
                self.systemIdentifier!.contains("gb")  ||
                self.systemIdentifier!.contains("segacd")  ||
                self.systemIdentifier!.contains("gba")  ||
                self.systemIdentifier!.contains("psx")  ||
                self.systemIdentifier!.contains("pce") ||
                self.systemIdentifier!.contains("ds") ||
                self.systemIdentifier!.contains("psp") ||
                self.systemIdentifier!.contains("n64")) {
                self.retroArchControls = retroControl
                self.hasTouchControls = true
            }
            if (self.systemIdentifier!.contains("dos")  ||
                self.systemIdentifier!.contains("mac")  ||
                self.systemIdentifier!.contains("pc98")) {
                self.retroArchControls = retroControl
                self.hasTouchControls = true
                optionValues += "input_auto_game_focus = \"1\"\n"
            }
            if (self.systemIdentifier!.contains("dos")  ||
                self.systemIdentifier!.contains("mac")  ||
                self.systemIdentifier!.contains("pc98") ||
                self.systemIdentifier!.contains("neo")
            ) {
                self.extractArchive = false;
            }
        }
        if (self.coreIdentifier != nil && self.coreIdentifier!.contains("mupen")) {
            let rdpOpt = PVRetroArchCore.valueForOption(PVRetroArchCore.mupenRDPOption).asInt ?? 1
            if (rdpOpt == 0) {
                optionValues += "mupen64plus-rdp-plugin = \"angrylion\"\n"
            } else {
                optionValues += "mupen64plus-rdp-plugin = \"gliden64\"\n";
            }
            optionValuesFile = "Mupen64Plus-Next/Mupen64Plus-Next.opt"
            optionOverwrite = true
        }
        if (self.coreIdentifier != nil && self.coreIdentifier!.contains("ppsspp")) {
            optionValues += "ppsspp_cpu_core = \"Interpreter\"\n"
            optionValues += "ppsspp_internal_resolution = \"1920x1088\"\n"
            optionValues += "ppsspp_texture_scaling_level = \"5x\"\n"
            optionValuesFile = "PPSSPP/PPSSPP.opt"
            optionOverwrite = false
        }
        if (self.coreIdentifier != nil && self.coreIdentifier!.contains("psx_hw")) {
            optionValues += "beetle_psx_hw_renderer = \"hardware_vk\"\n"
            optionValues += "beetle_psx_hw_renderer_software_fb = \"enabled\"\n"
            optionValues += "beetle_psx_hw_pgxp_2d_tol = \"0px\"\n"
            optionValues += "beetle_psx_hw_pgxp_mode = \"memory only\"\n"
            optionValues += "beetle_psx_hw_pgxp_nclip = \"enabled\"\n"
            optionValues += "beetle_psx_hw_internal_resolution = \"4x\"\n"
            optionValues += "beetle_psx_hw_dither_mode = \"internal resolution\"\n"
            optionValues += "beetle_psx_hw_pgxp_texture = \"enabled\"\n"
            optionValues += "beetle_psx_hw_pgxp_vertex = \"enabled\"\n";
            optionValuesFile = "Beetle PSX HW/Beetle PSX HW.opt"
            optionOverwrite = false
        } else if (self.coreIdentifier != nil && self.coreIdentifier!.contains("psx")) {
            optionValues += "beetle_psx_gxp_2d_tol = \"0px\"\n"
            optionValues += "beetle_psx_pgxp_mode = \"memory only\"\n"
            optionValues += "beetle_psx_pgxp_nclip = \"enabled\"\n"
            optionValues += "beetle_psx_gpu_overclock = \"32x\"\n"
            optionValues += "beetle_psx_internal_resolution = \"4x\"\n"
            optionValues += "beetle_psx_dither_mode = \"internal resolution\"\n"
            optionValues += "beetle_psx_pgxp_texture = \"enabled\"\n"
            optionValues += "beetle_psx_pgxp_vertex = \"enabled\"\n";
            optionValuesFile = "Beetle PSX/Beetle PSX.opt"
            optionOverwrite = false
        }
        self.coreOptionConfig = optionValues;
        self.coreOptionConfigPath = optionValuesFile
        self.coreOptionOverwrite = optionOverwrite
    }
}

extension PVRetroArchCore: GameWithCheat {
	@objc public func setCheat(code: String, type: String, codeType: String, cheatIndex: UInt8, enabled: Bool) -> Bool {
		do {
			NSLog("Calling setCheat \(code) \(type) \(codeType)")
			try self.setCheat(code, setType: type, setCodeType: codeType, setIndex: cheatIndex, setEnabled: enabled)
			return true
		} catch let error {
            NSLog("Error setCheat \(error)")
			return false
		}
	}
    @objc
    public var supportsCheatCode: Bool { return true }
    @objc
    public var cheatCodeTypes: [String] { return [] }
}

@objc public extension PVRetroArchCore {
    @objc func useSecondaryScreen() {
        if UIScreen.screens.count > 1 {
            let secondaryScreen:UIScreen = UIScreen.screens[1]
            if (self.window == nil) {
                let secondaryWindow = UIWindow(frame: secondaryScreen.bounds)
                self.window = secondaryWindow
                self.window.screen = UIScreen.main
                if let touchController = CocoaView.get().parent, let emuController = touchController.parent {
                    emuController.removeFromParent()
                    secondaryWindow.rootViewController = emuController
                }
                self.window.isHidden=false
            }
            self.window.screen = secondaryScreen
        }
    }
    @objc func usePrimaryScreen() {
        if UIScreen.screens.count > 1 && self.window != nil && self.window != UIApplication.shared.keyWindow {
            self.window.screen = UIScreen.main
        }
    }
}

extension PVRetroArchCore: CoreActions {
    public var coreActions: [CoreAction]? {
        return [CoreAction(title: "Game Options (RetroArch Options Menu)", options: nil, style:.default)]
    }
    public func selected(action: CoreAction) {
        switch action.title {
            case "Game Options (RetroArch Options Menu)":
                menuToggle()
                break;
            default:
                print("Unknown action: " + action.title)
        }
    }
}
