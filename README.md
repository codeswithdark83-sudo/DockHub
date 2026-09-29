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

</div>

---

## About

DockHub is a clean, fast startpage for keeping all your favorite websites and tools in one place. Organize links into customizable categories, find anything with instant search, and switch between a polished dark mode and light mode. The whole app lives in one `index.html` file, so you can open it locally or host it anywhere for free.

## Live Demo

- **Hosted version:** https://dock-hub.vercel.app

## Features

### Layout
- **Navbar:** logo and app name on the left, global search in the center, and on the right the *Add Category* and *Add Bookmark* buttons, a dark/light toggle and a profile avatar.
- **Category grid:** fluid, responsive grid of collapsible category sections.
- **Editable categories:** click a title to rename it, click the icon to cycle through category icons, and delete a category with its bookmarks.
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

### Accounts (Supabase)
- **Email and password** sign-up and sign-in with email confirmation and password reset.
- **Continue with Google** through real Supabase OAuth.
- **Cloud sync:** each account's bookmarks are stored in Supabase and follow you across devices.
- **Admin dashboard** (admin email only): total users, new and active users in the last 7 days, sign-in method, and a table of names and emails with CSV export. Access is enforced on the server, not just in the UI.

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
| Storage | Supabase for accounts, `localStorage` for guests |
| Icons and logos | Hand-drawn inline SVG |
| Hosting | GitHub Pages or any static host |

## Project Structure

```
dockhub/
├── index.html    # the entire app (HTML, CSS and JS)
├── favicon.svg   # DockHub logo
├── supabase-setup.sql  # database tables, security rules, admin functions
└── README.md
```

## Getting Started

**Run locally**

```bash
git clone https://github.com/<your-username>/dockhub.git
cd dockhub
# open index.html in your browser
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
5. In **Authentication > URL Configuration**, set the **Site URL** to your GitHub Pages address (for example `https://<your-username>.github.io/dockhub/`) and add it to **Redirect URLs**.
6. For Google sign-in, create an OAuth client in Google Cloud Console (type *Web application*), add the callback URL shown in **Authentication > Providers > Google** to its authorized redirect URIs, then paste the client ID and secret into that Supabase page and enable it.

## Limitations

- **Needs Supabase to sign in:** without the config values the app still works as a guest with browser-only storage, and the sign-in button explains what to set up.
- **Hosting:** the Supabase version is meant for GitHub Pages or any normal host. It does not work inside the claude.ai preview, which blocks outside network requests.
- **No automatic favicon fetching:** browsers block cross-site image requests on some hosts. You can add a favicon service or a small proxy.
## Roadmap

- [ ] Drag-and-drop reordering for bookmarks and categories
- [ ] Import and export (JSON / browser bookmarks)
- [ ] Automatic favicon fetching through a proxy
- [ ] PWA support (installable, offline)

## About the Developer

**Jatin Kr. Koli**
Developer and creator of DockHub.

- GitHub: [@codeswithdark83-sudo](https://github.com/codeswithdark83-sudo)
- Email: [codeswithdark83@gmail.com](mailto:codeswithdark83@gmail.com)

> Replace the name, GitHub username and links above with your own details.

## Contributing

Ideas and improvements are welcome. Fork the repo, create a branch, make your changes and open a pull request.

---

<div align="center">

If you like DockHub, give it a star.

</div>
