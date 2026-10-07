import { defineConfig, devices } from '@playwright/test';

const baseURL =
  process.env.BASE_URL ?? 'https://verzel-store.qa-test-verzel-store.workers.dev';

// Navegador da UI: Google Chrome instalado na máquina (canal "chrome").
const channel = process.env.PW_BROWSER === 'chromium' ? undefined : 'chrome';

// Ambiente compartilhado: execução leve, sem paralelismo agressivo.
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  workers: 1,
  retries: 0,
  timeout: 30_000,
  expect: { timeout: 5_000 },
  reporter: [['html', { open: 'never' }], ['list']],
  use: {
    testIdAttribute: 'data-valor',
    baseURL,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'ui',
      testMatch: /.*\.ui\.spec\.ts/,
      use: { ...devices['Desktop Chrome'], channel },
    },
    {
      name: 'api',
      testMatch: /.*\.api\.spec\.ts/,
    },
  ],
});
