import verify from './verify'
import tools from './tools'

const install = Vue => {
    if (install.installed) {
        // 如果已经注册过了，就跳过
        return;
    }
    install.installed = true;

    Vue.prototype.$verify = verify;
    Vue.prototype.$tools = tools;
};

export default install
