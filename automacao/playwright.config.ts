import { defineConfig, devices } from '@playwright/test';

const baseURL =
  process.env.BASE_URL ?? 'https://verzel-store.qa-test-verzel-store.workers.dev';

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
    baseURL,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'ui',
      testMatch: /.*\.ui\.spec\.ts/,
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'api',
      testMatch: /.*\.api\.spec\.ts/,
    },
  ],
});
