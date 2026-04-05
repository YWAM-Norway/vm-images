# Debloating Windows 11
# Erik Grøtnes 05.04.2026
#
# Using Raphire's Win11 Debloat program
# https://github.com/Raphire/Win11Debloat/wiki/Command%E2%80%90line-Interface#parameters
#

$ErrorActionPreference = 'Stop'

$workDir    = Join-Path $env:TEMP 'DebloatConfig'
$configPath = Join-Path $workDir 'configfil.json'

try {
    # Opprett arbeidsmappe
    New-Item -Path $workDir -ItemType Directory -Force | Out-Null

    # Skriv config-fil
    @'
{
    "Apps": [
        "Microsoft.3DBuilder",
        "Microsoft.Microsoft3DViewer",
        "ACGMediaPlayer",
        "ActiproSoftwareLLC",
        "AdobeSystemsIncorporated.AdobePhotoshopExpress",
        "Microsoft.WindowsAlarms",
        "Amazon.com.Amazon",
        "Asphalt8Airborne",
        "AutodeskSketchBook",
        "Microsoft.BingFinance",
        "Microsoft.BingFoodAndDrink",
        "Microsoft.BingHealthAndFitness",
        "Microsoft.BingNews",
        "Microsoft.BingSports",
        "Microsoft.BingTranslator",
        "Microsoft.BingTravel",
        "Microsoft.BingWeather",
        "king.com.BubbleWitch3Saga",
        "CaesarsSlotsFreeCasino",
        "king.com.CandyCrushSaga",
        "king.com.CandyCrushSodaSaga",
        "Clipchamp.Clipchamp",
        "COOKINGFEVER",
        "Microsoft.Copilot",
        "Microsoft.Windows.AIHub",
        "Microsoft.549981C3F5F10",
        "CyberLinkMediaSuiteEssentials",
        "Microsoft.Windows.DevHome",
        "Disney",
        "DisneyMagicKingdoms",
        "DrawboardPDF",
        "Duolingo-LearnLanguagesforFree",
        "EclipseManager",
        "Facebook",
        "MicrosoftCorporationII.MicrosoftFamily",
        "FarmVille2CountryEscape",
        "Microsoft.WindowsFeedbackHub",
        "fitbit",
        "Flipboard",
        "Microsoft.Getstarted",
        "HiddenCity",
        "HULULLC.HULUPLUS",
        "iHeartRadio",
        "Instagram",
        "LinkedInforWindows",
        "Sidia.LiveWallpaper",
        "MarchofEmpires",
        "Microsoft.MicrosoftJournal",
        "Microsoft.News",
        "Microsoft.PCManager",
        "Microsoft.MixedReality.Portal",
        "Microsoft.ZuneVideo",
        "Netflix",
        "NYTCrossword",
        "Microsoft.MicrosoftOfficeHub",
        "OneCalendar",
        "Microsoft.OneConnect",
        "PandoraMediaInc",
        "PhototasticCollage",
        "PicsArt-PhotoStudio",
        "Plex",
        "PolarrPhotoEditorAcademicEdition",
        "Microsoft.PowerAutomateDesktop",
        "Microsoft.MicrosoftPowerBIForWindows",
        "AmazonVideo.PrimeVideo",
        "Microsoft.Print3D",
        "MicrosoftCorporationII.QuickAssist",
        "Royal Revolt",
        "Shazam",
        "Microsoft.SkypeApp",
        "SlingTV",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.WindowsSoundRecorder",
        "Spotify",
        "Microsoft.MicrosoftStickyNotes",
        "Microsoft.Office.Sway",
        "TikTok",
        "TuneInRadio",
        "Twitter",
        "Viber",
        "Microsoft.WindowsMaps",
        "Microsoft.XboxApp",
        "Microsoft.XboxGameOverlay",
        "Microsoft.GamingApp",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.Xbox.TCUI",
        "XING"
    ],
    "Tweaks": [
        {
            "Value": true,
            "Name": "DisableStoreSearchSuggestions"
        },
        {
            "Value": true,
            "Name": "DisableStartPhoneLink"
        },
        {
            "Value": true,
            "Name": "ShowKnownFileExt"
        },
        {
            "Value": true,
            "Name": "DisableBing"
        }
    ],
    "Deployment": [
        {
            "Value": 2,
            "Name": "UserSelectionIndex"
        },
        {
            "Value": 0,
            "Name": "AppRemovalScopeIndex"
        },
        {
            "Value": false,
            "Name": "CreateRestorePoint"
        },
        {
            "Value": false,
            "Name": "RestartExplorer"
        }
    ],
    "Version": "1.0"
}
'@ | Set-Content -Path $configPath -Encoding UTF8

    Write-Host "Config skrevet til: $configPath"

    # Last ned og kjør scriptet med parametere
    $scriptContent = Invoke-RestMethod -Uri 'https://debloat.raphi.re/'

    & ([scriptblock]::Create($scriptContent)) -Config $configPath -Silent

    Write-Host 'Debloat fullført.'
}
finally {
    # Rydd opp
    if (Test-Path $workDir) {
        Remove-Item -Path $workDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}
