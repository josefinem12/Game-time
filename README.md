# Deep Cut: putting it online

The site is 4 files: `index.html`, `questions.js`, `config.js`, `schema.sql` (plus this guide).
It works straight away offline. These steps add the shared leaderboard and a public link. It takes about 15 minutes, everything is free, and no coding is needed.

## Part 1: create the database (Supabase)

1. Go to **supabase.com**, sign up (GitHub or email), and click **New project**.
   Give it a name (e.g. `deepcut`), set any database password (save it somewhere), pick the region closest to you (e.g. Singapore), and create it. Wait ~2 minutes while it sets up.
2. In the left menu open **SQL Editor** → **New query**. Open `schema.sql`, copy everything, paste it in and press **Run**. You should see "Success".
3. Open **Project Settings → API** (in newer dashboards, **Project Settings → Data API** and **API Keys**). Copy:
   - the **Project URL** (looks like `https://abcdxyz.supabase.co`)
   - the **anon / public** key (a long string starting `eyJ…`, or `sb_publishable_…`). Don't use the `service_role` / secret key.
4. Open `config.js` in any text editor (Notepad, TextEdit) and paste them between the quotes:
   ```js
   supabaseUrl: "https://abcdxyz.supabase.co",
   supabaseAnonKey: "eyJhbGciOi..."
   ```
   Save the file.

## Part 2: put the site online (GitHub Pages)

1. Go to **github.com**, sign up, then click **+ → New repository**. Name it `deepcut`, set it to **Public**, and create it.
2. On the new repo page click **uploading an existing file**, drag in `index.html`, `questions.js` and `config.js` (and the others if you like), then **Commit changes**.
3. Go to **Settings → Pages**. Under "Branch" pick **main** and **/(root)**, then **Save**.
4. After a minute or two the page shows your link: `https://YOUR-USERNAME.github.io/deepcut/`. Send that to anyone. It works on phones with no account needed.

**Easier alternative:** at **app.netlify.com/drop**, drag the whole folder onto the page and you get a link instantly. Make a free account so the link doesn't expire.

## Updating later
- To add questions or change something, replace the file on GitHub (open the file → pencil icon, or upload again). The site updates in about a minute.
- Questions live in `questions.js`. Each line is `[category, prompt, [6 tiers from most common to rarest], hard?]`. Answers are separated by commas, and alternative spellings by `/`.

## Good to know
- **Leaderboard:** today / this week / all time, top 25 dives. Names are whatever players type, and there are no logins.
- **Personal stats** (history, averages, best categories, rarest finds) are kept in each player's browser, so they are per device.
- **It's built for friends, not tournaments.** Someone technical could post a fake score. To remove one: Supabase → **Table Editor → dives** → select the row → delete.
- Every answer is also stored in the `answers` table. Later, this could power *real* rarity scoring based on what players actually answer.
