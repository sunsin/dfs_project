var src = './';
var dest = './build';

module.exports = {
    less: {
        all: src + "/less/**/*.less", //所有less
        src: src + "/less/*.less",      //需要编译的less
        dest: dest + "/css",          //输出目录
        rev: dest + "/rev/css",
        settings: {                      //编译less过程需要的配置，可以为空

        }
    },
    images: {
        all: src + "/images/**/*",
        src: src + "images/**/*",
        dest: dest + "/images"
    },
    css: {
        all: src + "/css/**/*",
        src: src + "css/**/*",
        dest: dest + "/css",
        rev: dest + "/rev/css"
    },
    fonts: {
        all: src + "/fonts/**/*",
        src: src + "fonts/**/*",
        dest: dest + "/fonts"
    },
    js: {
        src: src + "js/**/*",
        dest: dest + "/js",
        rev: dest + "/rev/js"
    },
    clean: {
        src: dest
    },
    rev: {//use rev to reset html resource url
        revJson: dest + "/**/*.json",
        src: "./html/*.html",//root index.html
        dest: dest + "/html"
    },
    rev2: {//use rev to reset html resource url
        revJson: dest + "/**/*.json",
        src: "./*.html",//root index.html
        dest: dest + "/"
    }
}