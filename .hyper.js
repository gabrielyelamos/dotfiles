module.exports = {
  config: {
    fontSize: 15,
    fontFamily: 'Hack',
    cursorColor: 'rgba(255,255,255,0.5)',
    cursorShape: 'BLOCK',
    foregroundColor: '#EEEEEE',
    backgroundColor: '#111111',
    borderColor: '#333',
    css: '',
    termCSS: '',
    showHamburgerMenu: true,
    showWindowControls: false,
    padding: '12px 14px',
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff'
    },
    shell: '',
    shellArgs: ['--login'],
    env: {
      LANG: 'fr_FR.UTF-8'
    },
    bell: false,
    copyOnSelect: true
  },
  plugins: [
    'hyperterm-chesterish',
    'hyper-statusline',
    'hyperterm-paste',
    'hyperterm-tabs',
    'hyperlinks'
  ],
  localPlugins: []
};
