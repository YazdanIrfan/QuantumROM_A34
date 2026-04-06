l#!/bin/bash

###################################################################################################

RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

DEBLOAT_APPS=(
"HMT" "PaymentFramework" "Duo" "FactoryCameraFB" "WlanTest" "DuoStub"
"AndroidDeveloperVerifier" "AndroidGlassesCore" "SOAgent77" "SamsungBilling"
"AirGlance" "AirReadingGlass" "SamsungTTS" "WlanTest" "ARCore" "ARDrawing"
"ARZone" "BGMProvider" "BixbyWakeup" "BlockchainBasicKit" "Cameralyzer"
"DictDiotekForSec" "EasymodeContactsWidget81" "Fast" "FBAppManager_NS"
"FunModeSDK" "KidsHome_Installer" "LinkSharing_v11" "LiveDrawing"
"MAPSAgent" "MinusOnePage" "MoccaMobile" "Netflix_stub" "ParentalCare"
"PhotoTable" "PlayAutoInstallConfig" "SamsungPassAutofill_v1"
"SmartReminder" "SmartSwitchStub" "UniversalMDMClient"
"VideoEditorLite_Dream_N" "VisionIntelligence3.7" "VoiceAccess"
"VTCameraSetting" "WebManual" "WifiGuider" "KTAuth" "KTCustomerService"
"KTUsimManager" "LGUMiniCustomerCenter" "LGUplusTsmProxy" "SketchBook"
"SKTMemberShip_new" "SktUsimService" "TWorld" "AirCommand"
"AppUpdateCenter" "AREmoji" "AREmojiEditor" "AutoDoodle"
"AvatarEmojiSticker" "AvatarEmojiSticker_S" "Bixby" "BixbyInterpreter"
"BixbyVisionFramework3.5" "DigitalKey" "Discover" "DiscoverSEP"
"EarphoneTypeC" "FBInstaller_NS" "FBServices" "FotaAgent"
"GalleryWidget" "HashTagService" "LedCoverService" "LiveStickers"
"MemorySaver_O_Refresh" "OMCAgent5" "OneDrive_Samsung_v3"
"OneStoreService" "SamsungCarKeyFw" "SamsungPass"
"SamsungSmartSuggestions" "SettingsBixby" "SetupIndiaServicesTnC"
"SKTFindLostPhone" "SKTHiddenMenu" "SKTMemberShip"
"SKTOneStore" "SktUsimService" "SmartEye" "SmartPush"
"SmartTouchCall" "SOAgent7" "SOAgent75" "SolarAudio-service"
"SPPPushClient" "sticker" "StickerFaceARAvatar" "StoryService"
"SumeNNService" "SVoiceIME" "SwiftkeyIme" "SwiftkeySetting"
"SystemUpdate" "TADownloader" "TalkbackSE" "TaPackAuthFw"
"TPhoneOnePackage" "TPhoneSetup" "TWorld" "UltraDataSaving_O"
"Upday" "UsimRegistrationKOR" "AvatarPicker" "GpuWatchApp"
"KT114Provider2" "KTHiddenMenu" "KTOneStore" "KTServiceAgent"
"KTServiceMenu" "LGUGPSnWPS" "LGUHiddenMenu" "LGUOZStore"
"SKTFindLostPhoneApp" "SmartPush_64" "SOAgent76" "TService"
"vexfwk_service" "VexScanner" "LiveEffectService"
)

REMOVE_ESIM_FILES() {
    local EXTRACTED_FIRM_DIR="$1"
    echo -e "- Removing ESIM files."
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/autoinstalls/autoinstalls-com.google.android.euicc"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/default-permissions/default-permissions-com.google.android.euicc.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/permissions/privapp-permissions-com.samsung.euicc.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/permissions/privapp-permissions-com.samsung.android.app.esimkeystring.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/permissions/privapp-permissions-com.samsung.android.app.telephonyui.esimclient.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/privapp-permissions-com.samsung.android.app.telephonyui.esimclient.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/sysconfig/preinstalled-packages-com.samsung.euicc.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/sysconfig/preinstalled-packages-com.samsung.android.app.esimkeystring.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/EsimClient"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/EsimKeyString"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/EuiccService"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/EuiccGoogle"
}

REMOVE_FABRIC_CRYPTO() {
    local EXTRACTED_FIRM_DIR="$1"
    echo -e "- Removing fabric crypto."
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/bin/fabric_crypto"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/init/fabric_crypto.rc"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/permissions/FabricCryptoLib.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/vintf/manifest/fabric_crypto_manifest.xml"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/framework/FabricCryptoLib.jar"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/lib64/com.samsung.security.fabric.cryptod-V1-cpp.so"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/lib64/vendor.samsung.hardware.security.fkeymaster-V1-ndk.so"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/KmxService"
}

KICK() {
    local EXTRACTED_FIRM_DIR="$1"

    echo -e "- Debloating apps."
    local APP_DIRS=(
        "$EXTRACTED_FIRM_DIR/system/system/app"
        "$EXTRACTED_FIRM_DIR/system/system/priv-app"
        "$EXTRACTED_FIRM_DIR/product/app"
        "$EXTRACTED_FIRM_DIR/product/priv-app"
    )

    for app in "${DEBLOAT_APPS[@]}"; do
        for dir in "${APP_DIRS[@]}"; do
            target="$dir/$app"
            if [[ -d "$target" ]]; then
                rm -rf "$target" || echo -e "[WARN] Failed to remove $target"
            fi
        done
    done
}

DEBLOAT() {
    local EXTRACTED_FIRM_DIR="$1"

    echo -e "${YELLOW}Debloating apps and files.${NC}"
    KICK "$EXTRACTED_FIRM_DIR"
    REMOVE_ESIM_FILES "$EXTRACTED_FIRM_DIR"
    REMOVE_FABRIC_CRYPTO "$EXTRACTED_FIRM_DIR"

    echo -e "- Cleaning unnecessary files."
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/app"/SamsungTTS*
    # ❌ boot-image.prof and bprof REMOVED FROM DELETION (kept for performance)
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/etc/mediasearch"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/hidden"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/preload"
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/priv-app/MediaSearch"
    # ❌ GameDriver-* REMOVED FROM DELETION (kept for GPU performance)
    rm -rf "$EXTRACTED_FIRM_DIR/system/system/tts"
    rm -rf "$EXTRACTED_FIRM_DIR/product/app/SpeechServicesByGoogle/oat"
    rm -rf "$EXTRACTED_FIRM_DIR/product/priv-app"/HotwordEnrollment*
}