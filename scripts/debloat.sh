#!/bin/bash

###################################################################################################

RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

# =========================
# GENERAL / SYSTEM / BLOAT
# =========================
DEBLOAT_APPS=(
"HMT" "PaymentFramework" "FactoryCameraFB"
"WlanTest" "AirGlance" "AirReadingGlass" "AndroidGlassesCore"
"SOAgent77" "ARCore" "ARDrawing" "ARZone" "BGMProvider"
"SingleTakeService" "BixbyWakeup" "BlockchainBasicKit"
"Cameralyzer" "DictDiotekForSec" "EasymodeContactsWidget81"
# Aura / AppCloud bloat
"com.aura.oobe.samsung.gl"
"com.aura.oobe.samsung"
"com.ironsource.appcloud.oobe"

"Fast" "FunModeSDK" "GearManagerStub" "KidsHome_Installer"
"LinkSharing_v11" "LiveDrawing" "MAPSAgent"
"MinusOnePage" "MoccaMobile" "Netflix_stub"
"ParentalCare" "PhotoTable" "SmartReminder" "SmartSwitchStub"
"UniversalMDMClient" "VideoEditorLite_Dream_N"
"VoiceAccess" "VTCameraSetting"
"WebManual" "WifiGuider" "AutomationTest_FB" "FactoryTestProvider"
)

# =========================
# CARRIER / REGION APPS
# =========================
CARRIER_APPS=(
"KTAuth" "KTCustomerService" "KTUsimManager"
"LGUMiniCustomerCenter" "LGUplusTsmProxy"
"SKTMemberShip_new" "SktUsimService" "TWorld"
"KT114Provider2" "KTHiddenMenu" "KTOneStore"
"KTServiceAgent" "KTServiceMenu"
"LGUGPSnWPS" "LGUHiddenMenu" "LGUOZStore"
"SKTFindLostPhone" "SKTHiddenMenu" "SKTMemberShip"
"SKTOneStore" "SKTFindLostPhoneApp"
"TPhoneOnePackage" "TPhoneSetup" "TService"
"UsimRegistrationKOR" "HpsAgreement_new" "KTAuth_Stub"
)

# =========================
# SAMSUNG APPS / FEATURES
# =========================
SAMSUNG_APPS=(
"SamsungBilling"
"OneDrive_Samsung_v3"
"SamsungCarKeyFw"
"SamsungPass"
"SamsungPassAutofill_v1"
"AirCommand"
"AppUpdateCenter"
"AREmoji"
"AREmojiEditor"
"AutoDoodle"
"AvatarEmojiSticker"
"AvatarEmojiSticker_S"
"AvatarPicker"
"GalleryWidget"
"StickerFaceARAvatar"
"sticker"
"MyGalaxy"
"SamsungShop"
"ShopSamsung"
)

# =========================
# SAMSUNG AI / SMART
# =========================
SAMSUNG_AI=(
"LiveTranscribe"
"Bixby"
"BixbyInterpreter"
"SettingsBixby"
"SmartEye"
"SmartPush"
"SmartPush_64"
"SmartTouchCall"
)

# =========================
# GOOGLE APPS
# =========================
GOOGLE_APPS=(
"SpeechServicesByGoogle"

# Removed Google Apps
"Maps"
"Duo"
"Photos"
"DuoStub"
"AndroidDeveloperVerifier"
"SamsungMessages"
"SearchSelector"
"YouTube"
"YouTubeStub"

# Newly Added
"Chrome"
"Gmail2"
"GlanceOnSamsung"
)

# =========================
# FACEBOOK
# =========================
FACEBOOK_APPS=(
"FBAppManager_NS"
"FBInstaller_NS"
"FBServices"
)

# =========================
# DRIVERS
# =========================
HARDWARE_DRIVERS=(

)

# =========================
# MISC SERVICES
# =========================
MISC_SERVICES=(
"AuthFramework"
"FotaAgent"
"HashTagService"
"LedCoverService"
"MemorySaver_O_Refresh"
"OMCAgent5"
"OneStoreService"
"FactoryAirCommandManager"
"SOAgent7"
"SOAgent75"
"SOAgent76"
"SolarAudio-service"
"SPPPushClient"
"SumeNNService"
"SVoiceIME"
"SystemUpdate"
"TADownloader"
"TalkbackSE"
"TaPackAuthFw"
"Upday"
"DsmsAPK"
"vexfwk_service"
"VexScanner"
"MyGalaxyService"

# Ultra Data Saving / Max VPN
"UltraDataSaving_O"
"UDS"
"MaxVPN"
"SamsungMax"
)

# =========================
# KNOX
# =========================
KNOX_APPS=(
"Rampart"
"KnoxFrameBufferProvider"
)

# =========================
# REMOVE ESIM
# =========================
REMOVE_ESIM_FILES() {
    local DIR="$1"

    echo "- Removing ESIM files."

    rm -rf "$DIR/system/system/etc/"*euicc*
    rm -rf "$DIR/system/system/priv-app/Esim"*
}

# =========================
# REMOVE FABRIC CRYPTO
# =========================
REMOVE_FABRIC_CRYPTO() {
    local DIR="$1"

    echo "- Removing fabric crypto."

    rm -rf "$DIR/system/system/bin/fabric_crypto"
    rm -rf "$DIR/system/system/framework/FabricCryptoLib.jar"
    rm -rf "$DIR/system/system/priv-app/KmxService"
}

# =========================
# CORE REMOVE FUNCTION
# =========================
KICK() {
    local DIR="$1"
    shift

    local APPS=("$@")

    local PATHS=(
        "$DIR/system/system/app"
        "$DIR/system/system/priv-app"
        "$DIR/system_ext/app"
        "$DIR/system_ext/priv-app"
        "$DIR/product/app"
        "$DIR/product/priv-app"
    )

    for app in "${APPS[@]}"; do
        for base in "${PATHS[@]}"; do

            target="$base/$app"

            if [[ -d "$target" ]]; then
                rm -rf "$target" || echo -e "[WARN] Failed to delete $target"
            fi

        done
    done
}

# =========================
# MAIN DEBLOAT
# =========================
DEBLOAT() {

    local DIR="$1"

    if [ ! -d "$DIR/system" ]; then
        echo "Invalid firmware path."
        return 1
    fi

    echo -e "${YELLOW}Starting debloat process...${NC}"

    KICK "$DIR" "${DEBLOAT_APPS[@]}"
    KICK "$DIR" "${CARRIER_APPS[@]}"
    KICK "$DIR" "${SAMSUNG_APPS[@]}"
    KICK "$DIR" "${SAMSUNG_AI[@]}"
    KICK "$DIR" "${GOOGLE_APPS[@]}"
    KICK "$DIR" "${FACEBOOK_APPS[@]}"
    KICK "$DIR" "${HARDWARE_DRIVERS[@]}"
    KICK "$DIR" "${MISC_SERVICES[@]}"
    KICK "$DIR" "${KNOX_APPS[@]}"

    REMOVE_ESIM_FILES "$DIR"
    REMOVE_FABRIC_CRYPTO "$DIR"
    echo -e "Debloating apps and files."


    echo -e "- Deleting unnecessary files and folders."
    # rm -rf "$EXTRACTED_FIRM_DIR/system/system/app"/SamsungTTS*
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/init/boot-image.bprof"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/init/boot-image.prof"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/hidden"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/preload"
	# rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/mediasearch"
	# rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/MediaSearch"
	# rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app"/GameDriver-*
	rm -rf "$EXTRACTED_FIRM_DIR/system/system/skt"
	# rm -rf "$EXTRACTED_FIRM_DIR/system/system/tts"
	# rm -rf "$EXTRACTED_FIRM_DIR/product/app/Gmail2/oat"
    # rm -rf "$EXTRACTED_FIRM_DIR/product/app/Maps/oat"
	# rm -rf "$EXTRACTED_FIRM_DIR/product/app/SpeechServicesByGoogle/oat"
	rm -rf "$EXTRACTED_FIRM_DIR/product/app/YouTube/oat"
	# rm -rf "$EXTRACTED_FIRM_DIR/product/priv-app"/HotwordEnrollment*

    echo -e "${YELLOW}Debloat completed.${NC}"
}


