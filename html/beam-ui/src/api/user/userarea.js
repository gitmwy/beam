import http from '@/util/http'

export default {
    getTreeData: params => {
        return http.get("/user/area/page/list", params)
    },
    add: params => {
        return http.post("/user/area/add", params)
    },
    options: params => {
        return http.get("/user/area/options", params)
    },
    batchDelete: ids =>{
        return http.post("/user/area/del", ids)
    },
    getAreaLevel: params =>{
        return http.get("/user/config/area/level", params)
    },
    edit: params =>{
        return http.get("/user/area/edit", params)
    },
}

