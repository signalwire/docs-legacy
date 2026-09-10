const path = require("path");

module.exports = function (context, options) {
  return {
    name: "docusaurus-plugin-image-alias",
    configureWebpack(config, isServer) {
      return {
        resolve: {
          alias: {
            "@image": path.resolve(context.siteDir, "./images"),
          },
        },
      };
    },
  };
};
