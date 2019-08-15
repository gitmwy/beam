import {MessageBox} from 'element-ui';

export default {
    //获取按钮权限
    getPerms:() =>{
        let buttonItems = sessionStorage.getItem("buttonItems");
        if (buttonItems) {
            return buttonItems;
        } else {
            return [];
        }
    },
    //修改递归最后一个子集为undefined
    getTreeData(data){
        for (let i = 0; i < data.length; i++) {
            if (data[i].children.length < 1) {
                // children若为空数组，则将children设为undefined
                data[i].children = undefined;
            } else {
                // children若不为空数组，则继续 递归调用 本方法
                this.getTreeData(data[i].children);
            }
        }
        return data;
    },
    //提示弹窗
    messageBox: (message, func) => {
        MessageBox.confirm(message, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            func();
        }).catch(() => {
        })
    },
    //拷贝
    assign:(params) => {
        return Object.assign({}, params);
    }
}
