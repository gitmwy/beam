import http from '@/util/http'

export default {
    getTreeData : params => {
        return http.get("/sys/menu/tree/menu", params);
    },
    // 新增
    add : params => {
        return http.post("/sys/menu/add", params)
    },
    // 编辑
    edit : params => {
        return http.get("/sys/menu/edit", params)
    },
    // 批量删除
    batchDelete : ids => {
        return http.post("/sys/menu/del", ids)
    },
}
