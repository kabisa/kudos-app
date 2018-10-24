import "babel-polyfill";
import "./styles/shell.scss";
import { h, render } from "preact";
import FastClick from "fastclick";
import { Provider } from "preact-redux";
import { ApolloProvider } from "react-apollo";
import { route } from "preact-router";

import "src/config/sentry";
import { store, client } from "./store";
import settings from "./config/settings";

import { getUserInfo, setToken } from "./modules/user/actions";
import { PATH_LOGIN } from "./routes";

const renderApp = function() {
  const App = require("./App").default;
  const root = document.querySelector("#maji-app");

  // Check for user token
  const token = localStorage.getItem(settings.LOCALSTORAGE_TOKEN);
  if (token) {
    store.dispatch(setToken(token));
    store.dispatch(getUserInfo());
  } else {
    if (!window.location.href.includes(`#${PATH_LOGIN}`)) {
      route(PATH_LOGIN);
    }
  }

  root.innerHTML = "";
  render(
    <ApolloProvider client={client}>
      <Provider store={store}>
        <App />
      </Provider>
    </ApolloProvider>,
    root
  );
};

FastClick.attach(document.body);
renderApp();

if (process.env.NODE_ENV !== "production") {
  require("preact/devtools");

  if (module.hot) {
    module.hot.accept();
  }
}
