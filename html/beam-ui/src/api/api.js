/*
 * 接口统一集成模块
 */
import AccountApi from './page/account'
import DashboardApi from './page/dashboard'
import LoginApi from './page/login'
//======================系统管理===============
import SysDeptApi from './sys/sysdept'
import SysDictApi from './sys/sysdict'
import SysLoginLogApi from './sys/sysloginlog'
import SysMenuApi from './sys/sysmenu'
import SysOperationLogApi from './sys/sysoperationlog'
import SysRoleApi from './sys/sysrole'
import SysScheduleApi from './sys/sysschedule'
import SysUserApi from './sys/sysuser'
//======================会议管理===============
import MeetingCourseApi from './meeting/meetingcourse'
import MeetingDetailApi from './meeting/meetingdetail'
import MeetingInfoApi from './meeting/meetinginfo'
import MeetingPlaceApi from './meeting/meetingplace'
import MeetingQuestionApi from './meeting/meetingquestion'
//======================用户管理===============
import UserRoleApi from './user/userrole'
import UserDetailApi from './user/userdetail'
import UserAreaApi from './user/userarea'
import UserConfigApi from './user/userconfig'
//======================医生管理===============
import HospitalDetailApi from './hospital/hospitaldetail'
import HospitalDoctorApi from './hospital/hospitaldoctor'
import HospitalAreaApi from './hospital/hospitalarea'

// 默认全部导出
export default {
    AccountApi,
    DashboardApi,
    LoginApi,
    //系统管理
    SysDeptApi,
    SysDictApi,
    SysLoginLogApi,
    SysMenuApi,
    SysOperationLogApi,
    SysRoleApi,
    SysScheduleApi,
    SysUserApi,
    //会议管理
    MeetingCourseApi,
    MeetingDetailApi,
    MeetingInfoApi,
    MeetingPlaceApi,
    MeetingQuestionApi,
    //用户管理
    UserRoleApi,
    UserDetailApi,
    UserAreaApi,
    UserConfigApi,
    //医生管理
    HospitalDetailApi,
    HospitalDoctorApi,
    HospitalAreaApi
}
