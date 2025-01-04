module.exports = {
  content: [
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/typography'),
  ],
  theme: {
    extend: {
      colors: {
        'main-color': '#336699',
        'link-border': '#e0dfe1',
        'link-hover': 'rgba(224, 223, 225, 0.8)',
      },
    },
  },
}
