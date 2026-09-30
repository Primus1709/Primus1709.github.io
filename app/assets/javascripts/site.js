// Small bits of behavior for the site. No framework needed.

// Theme toggle: switches between light and dark, and remembers the choice.
document.addEventListener("click", (event) => {
  const button = event.target.closest("[data-theme-toggle]");
  if (!button) return;

  const root = document.documentElement;
  const current = root.dataset.theme ||
    (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
  const next = current === "dark" ? "light" : "dark";

  root.dataset.theme = next;
  try {
    localStorage.setItem("theme", next);
  } catch (e) {
    // Storage can be blocked (private windows). The toggle still works for this page.
  }
});

// Delete buttons: ask before submitting any form that has data-confirm.
document.addEventListener("submit", (event) => {
  const message = event.target.dataset.confirm;
  if (message && !window.confirm(message)) {
    event.preventDefault();
  }
});
