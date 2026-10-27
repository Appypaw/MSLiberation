#!/usr/bin/env python3
"""Package the generated RGBA bezel as a mipmapped DXT5 PAA (requires Pillow >= 11).

Run: python3 tools/build_tablet_texture.py
Source geometry is restored by the UI's fixed 3:2 display rectangle. The GPU
texture uses power-of-two dimensions. No artwork is painted or regenerated here.
Format reference: https://community.bistudio.com/wiki/PAA_File_Format
"""
from io import BytesIO
from pathlib import Path
import struct
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'res/tablet/fieldnet_tablet_v2_source.png'
TARGET = ROOT / 'res/tablet/fieldnet_tablet_v2_ca.paa'

def build():
    image = Image.open(SOURCE).convert('RGBA').resize((2048, 1024), Image.Resampling.LANCZOS)
    chunks = []
    while min(image.size) >= 4:
        stream = BytesIO()
        image.save(stream, format='DDS', pixel_format='DXT5')
        dds = stream.getvalue()
        assert dds[:4] == b'DDS ' and dds[84:88] == b'DXT5'
        payload = dds[128:]
        width, height = image.size
        assert len(payload) == ((width + 3) // 4) * ((height + 3) // 4) * 16
        # Decode independently through Pillow before packaging the exact blocks.
        decoded = Image.open(BytesIO(dds))
        assert decoded.size == image.size and decoded.mode == 'RGBA'
        chunks.append(struct.pack('<HH', width, height) + len(payload).to_bytes(3, 'little') + payload)
        image = image.resize((width // 2, height // 2), Image.Resampling.LANCZOS)
    flag = b'GGATGALF' + struct.pack('<II', 4, 1)  # interpolated alpha
    offset = 2 + len(flag) + 12 + 64 + 2
    offsets = []
    for chunk in chunks:
        offsets.append(offset)
        offset += len(chunk)
    header = struct.pack('<H', 0xFF05) + flag
    header += b'GGATSFFO' + struct.pack('<I', 64) + struct.pack('<16I', *(offsets + [0] * (16 - len(offsets))))
    header += b'\x00\x00'  # no palette
    TARGET.write_bytes(header + b''.join(chunks) + b'\x00' * 6)
    data = TARGET.read_bytes()
    for position, chunk in zip(offsets, chunks):
        assert data[position:position + len(chunk)] == chunk
    print(f'PASS: {TARGET.relative_to(ROOT)}, {len(chunks)} DXT5 mipmaps, {len(data):,} bytes')

if __name__ == '__main__':
    build()
