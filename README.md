# GO! Eyewear — Sunglasses Built for Velocity

A sunglasses e-commerce site built with **Flutter Web + GetX**, reusing the
brand system, copy voice, and architecture from the GO! fashion project,
retargeted to eyewear with the UX patterns real sunglasses sites use.

## What's reused vs. new

**Reused from GO! (fashion):** the full visual identity — colors, type
system, the "!" mark, diagonal section cuts, the velocity ticker — plus the
brand-level copy (hero line, manifesto, founder's note, values, footer,
contact page). Same house, same voice.

**New for eyewear**, based on patterns from Ray-Ban, Sunglass Hut, and
Warby Parker:

- **Shop by Shape** — sunglasses are browsed by frame shape (Aviator,
  Round, Cat-Eye, Rectangle) rather than by gender or category, mirroring
  how every major eyewear retailer structures navigation.
- **Color swatches on the product page** — each frame ships in 2–3
  colorways; tapping a swatch swaps the product photo, the same as any
  eyewear PDP on the market.
- **Lens + frame-width selectors** — replaces clothing sizes with what
  actually varies on a pair of sunglasses (Polarized/Standard/Gradient
  lens, Narrow/Standard/Wide fit).
- **Find Your Fit** (`/find-your-fit`) — a face-shape guide (Round,
  Square, Oval, Heart) that recommends a frame shape and links straight
  into the filtered collection, the same "shop by face shape" pattern
  Warby Parker popularized.
- **Lens Technology band** on the homepage — UV400, polarization, and
  coating callouts, standard trust-building content on eyewear sites.

## ⚠️ About the photography — read before launch

Every image loads live from **https://picsum.photos**, a free placeholder
photo service, via a named seed — so the app renders real photography with
zero setup. These are **not** curated product shots. Before you launch,
replace the seeds with your own hosted photography:

1. **Frame photos per colorway** — `lib/app/data/repositories/product_repository.dart`,
   inside `_colors()` / `_buildCatalog()`.
2. **Hero / shape-tile / lookbook / face-guide photos** — seeds are
   defined in `home_controller.dart`, `lookbook_controller.dart`, and
   inline in `about_view.dart` / `find_your_fit_view.dart`.

Every image passes through the single `GoImage` widget
(`lib/app/global_widgets/go_image.dart`), so swapping sources is a matter
of changing URL strings, not restructuring widgets.

## Fonts

This project does **not** use the `google_fonts` package — no fonts are
fetched over the network at runtime. Custom fonts (Fraunces, Archivo
Black, Jost) are wired up as local assets instead. See
`assets/fonts/README.md` for exact download links and setup steps. Until
you add the files, the app runs fine and just falls back to the platform
default font.

## Project structure

```
lib/
  main.dart                     # registers services, boots GetMaterialApp
  app/
    theme/                      # colors, typography, ThemeData (shared w/ GO! fashion)
    data/
      models/                  # ProductModel, FrameShape, FrameColor
      repositories/             # ProductRepository, BagService (GetxServices)
    global_widgets/             # NavBar, SiteFooter, GoButton, GoImage,
                                 # ProductCard, GoMark, diagonal clippers, etc.
    routes/                     # Routes, AppPages (GetPage table)
    modules/
      home/                    # hero, manifesto, shop-by-shape, lens tech, featured
      collection/               # shape-filterable product grid
      product_detail/           # color/lens/width selectors, add to bag
      find_your_fit/            # face-shape guide (static, no controller needed)
      lookbook/                 # staggered editorial gallery
      about/                   # manifesto / brand story
      bag/                     # cart
      contact/                 # newsletter form
```

Each module follows View → Controller → Repository: controllers hold UI
state and call into `ProductRepository.to` / `BagService.to` (registered
once in `main.dart` as `GetxService`s so they survive navigation); views
are `GetView<T>` and read state via `Obx`/`Rx` types; bindings wire
controllers to routes lazily.

## Running it

```bash
flutter pub get
flutter run -d chrome
```

To build for deployment:

```bash
flutter build web
```

## Extending it

- **Checkout / payments:** `BagController.checkout()` in
  `modules/bag/controllers/bag_controller.dart` is a stub — wire it to
  your payment provider or a Firebase Cloud Function boundary.
- **Real catalog data:** swap `ProductRepository._buildCatalog()` for a
  Firestore/REST call — the public interface (`all()`, `byShape()`,
  `byId()`, `featured()`) stays the same, so no view code needs to change.
- **Prescription lenses:** if you sell Rx sunglasses, add a
  `prescriptionAvailable` flag to `ProductModel` and a form step before
  `addToBag()` in `ProductDetailController`.
- **Newsletter submissions:** `ContactController.submit()` currently just
  flips a local `submitted` flag — connect it to your email service of
  choice.
