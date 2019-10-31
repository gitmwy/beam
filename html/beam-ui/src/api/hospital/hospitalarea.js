import http from '@/util/http'

export default {
    getTreeData: params => {
        return http.get("/hospital/area/page/list", params)
    },
    add: params => {
        return http.post("/hospital/area/add", params)
    },
    options: params => {
        return http.get("/hospital/area/options", params)
    },
    batchDelete: ids =>{
        return http.post("/hospital/area/del", ids)
    },
    edit: params =>{
        return http.get("/hospital/area/edit", params)
    },
}

