# ThinkPad X13 Yoga Gen 2 – EasyEffects Audio Profile

Optimized 6-stage **EasyEffects 8.x (PipeWire)** speaker configuration for the **Lenovo ThinkPad X13 Yoga Gen 2** on Linux (Dolby Audio / Dolby Atmos replacement).

The internal downward/angled micro-speakers of the ThinkPad X13 Yoga Gen 2 sound flat, boxy around 900 Hz, and lack bass and soundstage out of the box on Linux. This profile configures a 6-stage DSP pipeline that protects the tiny speaker cones from sub-bass excursion while adding psychoacoustic upper-bass warmth, midrange de-boxiness, harmonic treble clarity, and M/S stereo widening.

---

## Signal Chain (6 Stages)

1. **Bass Enhancer (`bass_enhancer#0` – Calf Bass Enhancer)**
   - **Floor:** `95 Hz` (active) | **Scope:** `185 Hz` | **Harmonics:** `9.0` | **Amount:** `7.5 dB` | **Output Gain:** `+1.0 dB`
   - Generates upper-bass harmonics so basslines and kick drums sound full without driving sub-bass into the tiny speaker membranes.
2. **Equalizer (`equalizer#0` – LSP 16-Band Parametric Equalizer)**
   - **Sub-Bass Cut:** `31.5 Hz` (`-24 dB`), `50 Hz` (`-18 dB`), `80 Hz` (`-4 dB`) – prevents speaker distortion/rattling.
   - **Warmth & Punch:** `120 Hz` (`+4.5 dB`), `160 Hz` (`+5.5 dB`), `220 Hz` (`+4.5 dB`), `315 Hz` (`+2.5 dB`).
   - **Anti-Boxiness / Chassis Resonance Cut:** `630 Hz` (`-1.0 dB`), `900 Hz` (`-2.5 dB`), `1250 Hz` (`-1.5 dB`), `2800 Hz` (`-1.0 dB`).
   - **Presence & Air:** `4.5 kHz` (`+3.0 dB`), `8 kHz` (`+5.0 dB`), `14 kHz` (`+5.5 dB`) | **Output Gain:** `+2.5 dB`.
3. **Exciter (`exciter#0` – Calf Exciter)**
   - **Scope:** `4500 Hz` – `16000 Hz` | **Harmonics:** `7.5` | **Amount:** `3.5 dB`
   - Restores crisp vocal and instrument detail above 4.5 kHz.
4. **Stereo Tools (`stereo_tools#0` – Calf Stereo Tools)**
   - **Stereo Base:** `0.22` | **Side Level (`slev`):** `+2.5 dB`
   - Widens the stereo image so audio detaches from the center of the laptop chassis while keeping center vocals anchored.
5. **Loudness (`loudness#0` – LSP Loudness Compensator)**
   - **Volume:** `+3.5 dB` | **Output Gain:** `+2.5 dB`
   - Equal-loudness contour compensation for rich sound even at low-to-medium listening levels.
6. **Maximizer (`maximizer#0` – ZamMaximX2)**
   - **Threshold:** `-8.0 dB` | **Release:** `75 ms` | **Ceiling / Output Gain:** `+2.0 dB`
   - Brings up quiet passages and maximizes perceived loudness cleanly without hard clipping.

---

## Requirements

On Arch Linux / CachyOS:

```bash
sudo pacman -S easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 mda.lv2
```

---

## Installation

Clone the repository and run `./install.sh`:

```bash
git clone https://github.com/aengel/thinkpad-x13-easyeffects.git
cd thinkpad-x13-easyeffects
./install.sh
```

> **Note on Keyboard Volume Keys:**  
> Keep your hardware speaker (`HiFi__Speaker__sink`) as the default PipeWire output device. EasyEffects automatically intercepts application audio streams, while your ThinkPad hardware volume and mute keys (`Fn+F1`–`Fn+F3`) continue to control the hardware speaker amplifier directly.
