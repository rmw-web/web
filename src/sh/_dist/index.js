// window.dataLayer = window.dataLayer || [];

// function gtag() {
//   dataLayer.push(arguments);
// }

(async () => {
  // await navigator.serviceWorker.register("/s.js", {
  //   scope: "/"
  // });

  const doc = document,
    tag = (name, attr) => {
      let e = doc.createElement(name);
      Object.assign(e, attr);
      doc.head.appendChild(e);
    };

  let _ = document.getElementsByTagName("script")[0].src;

  const cdn = _.slice(0,_.lastIndexOf('/')+1);
  // tongji = "$tongji";

  //(await navigator.serviceWorker.ready).active.postMessage(cdn);

  // tag("script", {
  //   src: `//www.googletagmanager.com/gtag/js?id=${tongji}`,
  //   async: true
  // });

  // gtag("js", new Date());
  // gtag("config", tongji);

  //加载页面
  for (let [i, t] of _.split("#").slice(1).entries()) {
    for (let s of t.split("/")) {
      s = cdn + s + ".";
      i == 1
        ? tag("script", {
          src: s + "js"
        })
        : tag("link", {
          rel: "stylesheet",
          href: s + "css"
        });
    }
  }
})();
