import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/user/detail/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/user/detail/export", params)
    },
    userArea: params => {
        return http.get("/user/area/userArea", params)
    },
    userRole: params => {
        return http.get("/user/role/userRole", params)
    },
    batchDelete: ids =>{
        return http.post("/user/detail/del", ids)
    },
    add: params => {
        return http.post("/user/detail/add", params)
    },
    // 批量更改状态
    changeStatus: (userId, flag) => {
        return http.post("/user/detail/change/status/" + flag, userId)
    },
}
