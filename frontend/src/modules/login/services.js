import settings from "../../config/settings";
import axios from "../../axios";
import lokka from "../../lokka";

export function loginService(username, password) {
  // return axios
  //   .post(settings.API_BASE_URL + settings.API_LOGIN, { username, password })
  //   .then(resp => resp.data);
  lokka
    .query(
      `query {
        posts {
          id
          message
          kudos
        }
      }`
    )
    .then(result => {
      console.log(result);
    });
}

export function resetPasswordService(email) {
  return axios
    .post(settings.API_BASE_URL + settings.API_RESET_PASSWORD, { email })
    .then(resp => resp.data);
}
