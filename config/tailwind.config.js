const colors = {
  ...{
    "main": "#F7F7F7",
    "base": "#FFFFFF",
  }
}

module.exports = {
  content: [
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: colors
    }
  } 
}
