@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

$ANGELSCRIPT_VER = "2.32.0"
$BOOST_VER = "1.68.0"
$ZLIB_VER = "1.2.11"

$BOOST_VER_UNDERLINE = $BOOST_VER.Replace(".","_")
$ZLIB_VER_NUM = $ZLIB_VER.Replace(".","")

Write-Host '================================================================================='
Write-Host ''
Write-Host '   .d8888b.                                             888                     '
Write-Host '  d88P  Y88b                                            888                     '
Write-Host '  Y88b.                                                 888                     '
Write-Host '   "Y888b.    .d88b.   8888b.  888  888 888d888 .d8888b 88888b.  88888b.        '
Write-Host '      "Y88b. d8P  Y8b     "88b 888  888 888P"  d88P"    888 "88b 888 "88b       '
Write-Host '        "888 88888888 .d888888 888  888 888    888      888  888 888  888       '
Write-Host '  Y88b  d88P Y8b.     888  888 Y88b 888 888    Y88b.    888  888 888  888       '
Write-Host '   "Y8888P"   "Y8888  "Y888888  "Y88888 888     "Y8888P 888  888 888  888       '
Write-Host ''
Write-Host '  888888b.                     888    .d8888b.  888                             '
Write-Host '  888  "88b                    888   d88P  Y88b 888                             '
Write-Host '  888  .88P                    888   Y88b.      888                             '
Write-Host '  8888888K.   .d88b.   .d88b.  888888 "Y888b.   888888 888d888 8888b.  88888b.  '
Write-Host '  888  "Y88b d88""88b d88""88b 888       "Y88b. 888    888P"      "88b 888 "88b '
Write-Host '  888    888 888  888 888  888 888         "888 888    888    .d888888 888  888 '
Write-Host '  888   d88P Y88..88P Y88..88P Y88b. Y88b  d88P Y88b.  888    888  888 888 d88P '
Write-Host '  8888888P"   "Y88P"   "Y88P"   "Y888 "Y8888P"   "Y888 888    "Y888888 88888P"  '
Write-Host '                                                                       888      '
Write-Host '                                                                       888      '
Write-Host '====================================================================== 888 ======'
Write-Host ''
Write-Host "Seaurchin BootStrapではSeaurchinの開発環境を自動的に構築をします。"
Read-Host '続行するには Enter キーを押してください'
Write-Host '================================================================================='
Write-Host ''
Write-Host "* ライブラリ展開先フォルダと一時フォルダを生成します。"
Write-Host ''

function download($path, $name) {
  if (!(Test-Path "tmp\$name.zip")) {
    Write-Host "** $name のソースコードを取得します。"
    Write-Host "$path"
    Invoke-WebRequest -Uri "$path" -OutFile "tmp\$name.zip"
    Write-Host ""
  } else {
    Write-Host "** $name は既に取得済なので無視しました。"
    Write-Host ""
  }  
}

New-Item tmp\ -ItemType Directory >$null 2>&1
New-Item library\ -ItemType Directory >$null 2>&1

Write-Host "================================================================================="
Write-Host ""
Write-Host "* ライブラリ群のソースコードを取得します。"
Write-Host ""

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

download "https://www.angelcode.com/angelscript/sdk/files/angelscript_$ANGELSCRIPT_VER.zip" "angelscript"
download "https://dl.bintray.com/boostorg/release/$BOOST_VER/source/boost_$BOOST_VER_UNDERLINE.zip" "boost"
download "https://zlib.net/zlib$ZLIB_VER_NUM.zip" "zlib"

Write-Host "================================================================================="

pause