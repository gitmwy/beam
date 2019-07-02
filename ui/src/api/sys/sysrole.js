import http from '@/util/http'

export default {
    // 登录
    getData: params => {
        return http.get("/sys/role/page/list", params);
    },
    // 新增
    add: params => {
        return http.post("/sys/role/add", params)
    },
    // 删除
    batchDelete: ids => {
        return http.post("/sys/role/del", ids)
    },
    getMenuTreeData: params => {
        return http.get("/sys/menu/tree/menu", params);
    },
    getCheckMenuData: params => {
        return http.get("/sys/role/menu/list", params);
    },
    saveMuenPerms: params => {
        console.log(params);
        return http.post("/sys/role/configPerm", params);
    }
}
