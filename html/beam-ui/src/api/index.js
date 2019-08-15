// 导入所有接口
import api from './api'

const install = Vue => {
    if (install.installed) {
        return;
    }
    install.installed = true;

    Object.defineProperty(Vue.prototype, "$api", {
        get() {
            return api
        }
    })
};

export default install
