# Content Studio by Eddie Jung

Free, open-source creator analytics. Find the reels that gain followers, compare follow rates, and explore patterns with simple charts and playable previews.

**Your workspace stays on your computer.** No subscriptions, central account database, publishing permissions, or access to local video folders.

## Start in under a minute

Install [Node.js 22 or newer](https://nodejs.org), then:

```sh
git clone https://github.com/eddie-wq07/content-studio.git
cd content-studio
npm start
```

Open **http://localhost:5002**. No dependency installation is required. Choose **Try the demo**, **Import your insights**, or expand the Instagram connection guide. For another port: `PORT=5003 npm start`.

## Bring your content

- **Demo:** clearly labeled made-up numbers to learn the interface.
- **Import:** a Content Studio JSON export. Imports are read in the browser, never uploaded. The app strips unknown fields, including tokens and local paths.
- **Instagram:** run on localhost, create your own Meta app using Instagram Login, authorize a Business/Creator account, and paste its insights token. The app calls Meta through your localhost server. Tokens live in page memory only; reconnect after reloading.
- **Multiple creators:** use Add creator and the workspace picker. Every account has a separate browser-saved workspace. Switching accounts forgets the active token.
- **Backups:** Export data downloads a portable JSON file. Browser storage is not a backup; clearing site data removes your saved workspaces. Different browsers/computers have separate storage. No cross-device sync.

Meta app setup requires `instagram_business_basic` and `instagram_business_manage_insights`. Development apps require tester enrollment. A public OAuth service for arbitrary users requires Meta approval; this project does **not** claim to bypass that. [Official documentation](https://developers.facebook.com/docs/instagram-platform/instagram-api-with-instagram-login/).

Meta may not return follows or watch time for a reel. Missing metrics remain blank. Existing exports can contain manually captured phone insights; their source and capture time remain visible. Instagram media URLs expire: reconnect and refresh to renew previews. Reel previews link to Instagram if playback fails.

## Analytics

16 interactive comparisons, follower benchmarks, leaderboards, exact per-reel values, and sortable post columns. Follows are attributed to each reel; they are not net account growth. Follow rate = reel follows / views × 100. Views include replays; viewer-based rates use individual viewers. Overall follow rate uses total follows / total views, rather than averaging individual percentages.

Correlation scores measure a straight-line pattern from −1 to +1. They do not establish cause. Small samples, unequal post ages, reel length and shared denominators can affect patterns. Counts from phone captures and later API refreshes may differ in time. Daily API reporting uses completed Pacific days.

## Modular by design

| Module | Responsibility |
| --- | --- |
| `public/modules/schema.js` | Validates portable workspace imports and strips secrets/unknown fields |
| `public/modules/workspace.js` | Browser storage, account switching, demo generation, local Instagram provider |
| `api/instagram.js` | Fixed-endpoint Meta proxy; no token storage, no arbitrary URLs |
| `public/app.js` | Views, post sorting, previews and analytics |
| `scripts/dev.mjs` | Loopback-only local server |

To add a provider, return the portable workspace shape from `blank()` / `normalizeWorkspace()` in `schema.js`, then save it through `saveWorkspace()`. Keep platform-specific API behavior out of chart rendering. Add comparisons to `deepSpecs` using paired numeric metrics; unavailable values are excluded, not filled with zero.

## Public demo deployment

```sh
npm run check
npm test
npm run build
npx vercel --prod
```

Vercel serves `dist/`. The public site offers the demo and browser-only imports. Live token connections are disabled in hosted deployments: **use localhost for live data**. It contains no private creator dataset or account secrets. Separate password-protected coach sharing is intentionally not bundled in this public repository.

## Develop

`npm test` checks import isolation, invalid values, credential stripping and API request boundaries. `npm run check` checks syntax. The app is buildless locally and has no runtime dependencies.

Created by **Eddie Jung**. MIT licensed. Contributions welcome—see [CONTRIBUTING.md](CONTRIBUTING.md).
