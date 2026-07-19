# Fonts for GO!

This project does **not** use the `google_fonts` package — no fonts are
fetched over the network at runtime. Instead, drop the `.ttf` files below
into this folder, then uncomment the `fonts:` block in `pubspec.yaml`.

Until you do that, the app runs fine and just uses the platform default
font (Roboto/system font) as a fallback — nothing is broken by their
absence, it just won't have the exact custom look yet.

## Files to add

All three are free, open-source, and downloadable from Google Fonts:

**Fraunces** — https://fonts.google.com/specimen/Fraunces
- `Fraunces-Regular.ttf`
- `Fraunces-Medium.ttf` (weight 500)
- `Fraunces-SemiBold.ttf` (weight 600)
- `Fraunces-Italic.ttf`
- `Fraunces-MediumItalic.ttf` (weight 500, italic)

**Archivo Black** — https://fonts.google.com/specimen/Archivo+Black
- `ArchivoBlack-Regular.ttf`

**Jost** — https://fonts.google.com/specimen/Jost
- `Jost-Regular.ttf`
- `Jost-Medium.ttf` (weight 500)
- `Jost-SemiBold.ttf` (weight 600)

## Steps

1. Download each family as a .zip from the links above ("Download family").
2. Pull the specific weight files listed above out of the `static/` folder
   in each zip and place them directly in this `assets/fonts/` folder
   (flat, no subfolders needed — the names above are exactly what
   `pubspec.yaml` expects).
3. In `pubspec.yaml`, uncomment the `assets:` and `fonts:` block under
   `flutter:`.
4. Run `flutter pub get`.

That's it — `AppTypography` in `lib/app/theme/app_typography.dart` already
references these exact family names (`Fraunces`, `ArchivoBlack`, `Jost`),
so no code changes are needed once the files are in place.
