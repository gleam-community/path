import * as process from "node:process";

export const getOsType = () => {
  if (process.platform === "win32") {
    return "win32";
  } else {
    return "unix";
  }
};
