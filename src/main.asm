INCLUDE "src/hardware.inc"

SECTION "Start", ROM0[$100]
    jp Start

Start:
    ; Turn off LCD first
    ld a, 0
    ldh (rLCDC), a

    ; Load tile into VRAM
    ld hl, TileData
    ld de, $8000
    ld bc, 16       ; 1 tile = 16 bytes
    ldir

    ; Setup BG tilemap
    ld hl, $9800    ; BG tilemap start
    ld (hl), 0      ; Use tile 0
    ld a, 0
    ld (hl), a

    ; Turn on LCD
    ld a, %10010000 ; BG + LCD enable
    ldh (rLCDC), a

Forever:
    jp Forever

SECTION "TileData", ROMX[$150]
TileData:
    INCBIN "src/tiles.gb"
