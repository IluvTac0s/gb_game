; src/main.asm — minimal test
INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]
    jp Start
    db 0
    INCBIN "nintendo_logo.gbt"

SECTION "Start", ROM0[$150]
Start:
    ; Turn off LCD
    ld a,0
    ldh [$FF40],a

    ; Copy one tile from ROM to VRAM
    ld hl, TileData
    ld de, $8000
    ld bc, 16
CopyLoop:
    ld a,[hl]
    ld [de],a
    inc hl
    inc de
    dec bc
    ld a,b
    or c
    jr nz, CopyLoop

    ; Put tile 0 at top-left of BG
    ld hl,$9800
    ld a,0
    ld [hl],a

    ; Turn on LCD + BG
    ld a,%10010000
    ldh [$FF40],a

Forever:
    jp Forever

SECTION "TileData", ROM0
TileData:
    INCBIN "tiles.gbt"
