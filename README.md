<div align="center">

<img src="favicon.svg" alt="DockHub logo" width="84" height="84">

# DockHub

**A modern personal bookmark & tools dashboard (startpage) with smooth micro-animations.**

Single file. Zero dependencies. No build step.

![HTML5](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)
![Responsive](https://img.shields.io/badge/Responsive-Mobile%20%2B%20Desktop-7c8cff)

[Live Demo](#-live-demo) | [Features](#-features) | [Tech Stack](#-tech-stack) | [Getting Started](#-getting-started) | [About the Developer](#-about-the-developer)

![Version](https://img.shields.io/badge/version-1.0.0-7c8cff)

</div>

---

## About

DockHub is a clean, fast startpage for keeping all your favorite websites and tools in one place. Organize links into customizable categories, find anything with instant search, and switch between a polished dark mode and light mode. The whole app lives in one `index.html` file, so you can open it locally or host it anywhere for free.

## Live Demo

- **Live app:** https://dock-hub.vercel.app
- **Repository:** https://github.com/codeswithdark83-sudo/DockHub

## Features

### Layout
- **Navbar:** logo and app name on the left, global search in the center, and on the right the *Add Category* and *Add Bookmark* buttons, a dark/light toggle and a profile avatar.
- **Category grid:** fluid, responsive grid of collapsible category sections.
- **Editable categories:** click a title to rename it, click the icon to open a searchable picker of 100+ category icons, and delete a category with its bookmarks.
- **Bookmark cards:** rounded glassmorphism cards with a hover lift, a cursor-following glow, a logo, the site name and a 3-dot menu (edit / delete).

### Bookmarks
- **Add / edit modal:** URL, nickname, category dropdown and a live preview.
- **Smart title:** the nickname is filled in from the URL's domain, and you can override it.
- **Website logos:**
  - Built-in brand logos for about 20 popular sites (Gmail, Drive, Calendar, Docs, YouTube, Claude, ChatGPT, Gemini, GitHub, Figma, Notion, LinkedIn, Reddit, Instagram and more).
  - Custom logo upload (auto-cropped to a square).
  - Optional AI-generated icon (only inside the claude.ai runtime).
  - Colored letter tile fallback for everything else.

### Search
- **Instant filtering** of bookmarks as you type.
- **Web search fallback:** press `Enter` to search Google, or open a site directly if you typed a domain.
- **Keyboard shortcut:** press `/` to focus the search bar.

### Accounts (Supabase) — sign-in required
- **Login is mandatory.** A full-screen gate greets every visitor; the dashboard is hidden until they sign in or sign up.
- **Email and password** sign-up and sign-in with email confirmation and password reset.
- **Continue with Google** through real Supabase OAuth.
- **Cloud sync:** every add, edit, delete, or reorder of a category or bookmark immediately upserts the full state to Supabase for that user, so it follows them across devices. New accounts are automatically seeded with the default categories.
- **Admin dashboard** (admin email only): total users, new and active users in the last 7 days, sign-in method, and a table of names and emails with CSV export. Access is enforced on the server, not just in the UI.

### Organize your way
- **Drag-and-drop bookmarks:** reorder cards within a category or drag them into a different category.
- **Drag-and-drop categories:** grab the ⠿ grip in a category's header to reorder whole sections.
- **Touch-friendly fallback:** every bookmark's ⋮ menu and every category header also has Move up / Move down controls, so reordering works on phones and tablets where drag-and-drop isn't reliable.

### Install as an app
- DockHub is an installable **Progressive Web App**. Open the profile avatar → **Your account** → **Install app** to trigger the native install prompt on desktop and Android Chrome/Edge. On iOS Safari, the same option shows the "Add to Home Screen" steps, since iOS doesn't support automatic install prompts. Once installed, the option disappears from the menu automatically.
- A small service worker caches the app shell for fast repeat loads and basic offline support (it never caches Supabase or CDN calls).

### Welcome animation
- A short branded splash (logo pop-in, gradient background, fade-out) plays every time the app is opened, while the app loads in behind it.

### Icon picker
- 100+ built-in category icons across education, dev, finance, health, travel, food, entertainment, gaming, design, science and more, with a live search box so you can type e.g. "education" or "finance" instead of scrolling.

### Account panel
- Open the profile avatar to see your name, email and sign-in method, sync status, an **Install app** shortcut, an **Admin dashboard** shortcut (admin only), and an **About developer** link that opens the developer's Linktree. The app version is shown at the bottom of this panel and on the sign-in screen.

### Design and UX
- Dark-first aesthetic with a light theme and a smooth theme transition.
- Inter typography and a purple-to-violet gradient accent.
- Micro-animations: staggered entrances, modal pop-ins, animated accordions and icon hover effects.
- **Mobile:** single-column layout, accordion categories and a floating bottom navigation bar.
- Respects `prefers-reduced-motion` and device safe areas.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Markup | HTML5 |
| Styling | CSS3 (custom properties, Grid, Flexbox, `backdrop-filter`, keyframe animations) |
| Logic | Vanilla JavaScript (ES2020), no frameworks or libraries |
| Typography | [Inter](https://fonts.google.com/specimen/Inter) via Google Fonts |
| Backend | [Supabase](https://supabase.com) (Auth, Postgres, Row Level Security) via `supabase-js` v2 |
| Storage | Supabase (required — see [Login is mandatory](#accounts-supabase--sign-in-required)) |
| PWA | Web App Manifest + a Service Worker for installability and app-shell caching |
| Icons and logos | Hand-drawn inline SVG, 100+ searchable category icons |
| Hosting | GitHub Pages or any static host |

## Project Structure

```
dockhub/
├── index.html    # the entire app (HTML, CSS and JS)
├── favicon.svg   # DockHub logo
├── icon-192.png / icon-512.png  # app icons for install / home screen
├── manifest.json # Web App Manifest (PWA)
├── sw.js         # service worker (offline app-shell caching)
├── supabase-setup.sql  # database tables, security rules, admin functions
└── README.md
```

## Getting Started

**Run locally**

```bash
git clone https://github.com/codeswithdark83-sudo/DockHub.git
cd DockHub
# serve it (service workers need http/https, not file://)
npx serve .
# or: python3 -m http.server 5500
```

**Deploy with GitHub Pages**

1. Push the repository to GitHub.
2. Go to **Settings > Pages**.
3. Choose **Deploy from a branch**, select `main` and `/ (root)`, then save.
4. Your site will be live in a minute or two.

## Customization

- **Default bookmarks:** edit the `DEF` array near the top of the script in `index.html`.
- **Brand logos:** add entries to the `LOGOS` object (`domain: [background, svgMarkup]`).
- **Colors and theme:** change the CSS variables under `:root` and `:root[data-theme="light"]`.
- **Admin email:** change it in `supabase-setup.sql` (the real check) and in the `ADMIN` constant (button visibility only).
- **Category icons:** add or edit entries in the `ICON_DATA` array (`['emoji','search keywords']`).
- **App version:** bump the `VERSION` constant near the top of the script; it's shown on the sign-in screen and in the account panel.
- **Developer link:** change `DEV_LINK` to update where "About developer" points.

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `/` | Focus search |
| `Enter` (in search) | Web search or open a typed domain |
| `Esc` | Close modal or menu |

## Supabase Setup

1. Create a free project at [supabase.com](https://supabase.com).
2. Open **SQL Editor**, paste the contents of `supabase-setup.sql` and run it. Change the admin email in the file if you want a different admin.
3. In **Project Settings > API**, copy the **Project URL** and the **anon public key**, then paste them into `SUPABASE_URL` and `SUPABASE_ANON_KEY` at the top of the script in `index.html`. The anon key is safe to publish because Row Level Security protects the data. Never use the `service_role` key here.
4. In **Authentication > Providers > Email**, keep **Confirm email** turned on. The admin check requires a confirmed email.
5. In **Authentication > URL Configuration**, set the **Site URL** to your deployed address (for example your Vercel URL, or `https://<your-username>.github.io/dockhub/` on GitHub Pages) and add it to **Redirect URLs**.
6. For Google sign-in, create an OAuth client in Google Cloud Console (type *Web application*), add the callback URL shown in **Authentication > Providers > Google** to its authorized redirect URIs, then paste the client ID and secret into that Supabase page and enable it.

## Limitations

- **Needs Supabase to sign in:** without the config values filled in, the login gate can't authenticate anyone; clicking the account icon explains what to set up. Login is required — there is no guest mode once Supabase is configured.
- **Drag-and-drop is a desktop/mouse feature.** Most mobile browsers don't support the HTML5 Drag and Drop API on touchscreens, so reordering by dragging mainly works with a mouse or trackpad. Use the Move up / Move down controls on touch devices instead.
- **Install prompt varies by browser.** Only Chromium-based browsers (Chrome, Edge, Samsung Internet) show the automatic install prompt. iOS Safari and Firefox require the manual "Add to Home Screen" steps shown by the Install button.
- **Hosting:** the Supabase version is meant for GitHub Pages or any normal host. It does not work inside the claude.ai preview, which blocks outside network requests.
- **No automatic favicon fetching:** browsers block cross-site image requests on some hosts. You can add a favicon service or a small proxy.
## Roadmap

- [ ] Import and export (JSON / browser bookmarks)
- [ ] Automatic favicon fetching through a proxy

## About the Developer

**Jatin Kumar Koli**
Developer and creator of DockHub.

- Linktree: [linktr.ee/codeswithjatin](https://linktr.ee/codeswithjatin)
- GitHub: [@codeswithdark83-sudo](https://github.com/codeswithdark83-sudo)
- Email: [codeswithdark83@gmail.com](mailto:codeswithdark83@gmail.com)

The same Linktree is one tap away inside the app: profile avatar → **About developer**.

## Contributing

Ideas and improvements are welcome. Fork the repo, create a branch, make your changes and open a pull request.

---

<div align="center">

If you like DockHub, give it a star.

</div>
