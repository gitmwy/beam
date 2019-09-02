import verify from './verify'
import tools from './tools'
import bus from './bus'

const install = Vue => {
    if (install.installed) {
        // 如果已经注册过了，就跳过
        return;
    }
    install.installed = true;

    Vue.prototype.$verify = verify; //校验工具
    Vue.prototype.$tools = tools; //全局工具
    Vue.prototype.$bus = bus; //中转站，组件之间通信
};

export default install
