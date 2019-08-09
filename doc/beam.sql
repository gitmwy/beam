/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : beam

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 09/08/2019 17:26:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for meeting_course
-- ----------------------------
DROP TABLE IF EXISTS `meeting_course`;
CREATE TABLE `meeting_course`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课件名',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ftp路径',
  `file_size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大小',
  `download_times` int(20) NULL DEFAULT NULL COMMENT '课件下载次数',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ftp文件名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_course
-- ----------------------------
INSERT INTO `meeting_course` VALUES (87, 'w (1).jpg', 'course/', '1.34MB', 0, '2019-07-22 16:49:24', '2019-07-22 16:49:24', '50a6f630-4235-4c2d-80fa-92f5b590971e.jpg');
INSERT INTO `meeting_course` VALUES (88, 'w (16).jpg', 'course/', '956.27KB', 0, '2019-07-22 17:02:54', '2019-07-22 17:02:54', '3903ba1f-092e-4a7e-889d-0905fb953049.jpg');
INSERT INTO `meeting_course` VALUES (89, '科室汇管理后台需求文档_1.0.docx', 'course/', '802.77KB', 0, '2019-07-23 09:49:52', '2019-07-23 09:49:52', 'e5124314-5f74-479a-8d22-6a3c8706dcc0.docx');

-- ----------------------------
-- Table structure for meeting_detail
-- ----------------------------
DROP TABLE IF EXISTS `meeting_detail`;
CREATE TABLE `meeting_detail`  (
  `id` bigint(20) NOT NULL,
  `code` bigint(20) NULL DEFAULT NULL COMMENT '编号',
  `meeting_time` datetime(0) NULL DEFAULT NULL COMMENT '会议日期',
  `hospital_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '医院名称',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在省市',
  `courseware` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课件',
  `speakers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '讲者',
  `application_time` datetime(0) NULL DEFAULT NULL COMMENT '申请日期',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '来源',
  `flag` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态（01：待审核，02：待修改，03：带开展，04：开展中，05：已结束）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_detail
-- ----------------------------
INSERT INTO `meeting_detail` VALUES (1, 1, '2019-06-19 17:33:14', '协和', '北京', '人类简史', '霍金', '2019-06-19 17:33:46', '微信', '01');
INSERT INTO `meeting_detail` VALUES (2, 2, '2019-06-20 13:43:44', '同仁', '北京', '本草纲目', '华佗', '2019-06-20 13:44:02', 'QQ', '02');
INSERT INTO `meeting_detail` VALUES (3, 3, '2019-06-24 14:16:17', '海淀医院', '北京', '伤寒杂病论', '扁鹊', '2019-06-24 14:16:50', '微博', '03');
INSERT INTO `meeting_detail` VALUES (4, 4, '2019-06-24 14:17:52', '上海医院', '上海', '黄帝内经', '黄帝', '2019-06-24 14:18:22', '知乎', '04');
INSERT INTO `meeting_detail` VALUES (5, 5, '2019-06-24 14:18:42', '中心医院', '芝加哥', '五禽戏', '司马懿', '2019-06-24 14:19:30', '优酷', '05');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '*/5 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', NULL, 'com.ksh.beam.common.quartz.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002A636F6D2E6B73682E6265616D2E73797374656D2E656E746974792E7379732E5363686564756C654A6F6200000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E52657374456E746974795EADF9A34ADCA4C70200024C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000A75706461746554696D6571007E000D7872002E636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E4162737472616374456E74697479F87F9639587291B80200024A000B63757272656E74506167654A00087061676553697A6578720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C000000000000000102000078700000000000000000000000000000000A7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001680B7908A0787371007E001177080000016BBFEAF1B0787400047461736B74000D2A2F35202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737470740006E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0017000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RenrenScheduler', 'DESKTOP-5N8RA0F1565340932032', 1565342783425, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', NULL, 1565231570000, -1, 5, 'PAUSED', 'CRON', 1565231569000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002A636F6D2E6B73682E6265616D2E73797374656D2E656E746974792E7379732E5363686564756C654A6F6200000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E52657374456E746974795EADF9A34ADCA4C70200024C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000A75706461746554696D6571007E000D7872002E636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E4162737472616374456E74697479F87F9639587291B80200024A000B63757272656E74506167654A00087061676553697A6578720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C000000000000000102000078700000000000000000000000000000000A7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001680B7908A0787371007E001177080000016BBFEAF1B0787400047461736B74000D2A2F35202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737470740006E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0017000000007800);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1080345897063223298 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'task', 'test', NULL, '*/5 * * * * ?', 0, '测试', '2019-01-02 06:11:48', '2019-07-05 10:16:14');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY', '{\"qcloudRegion\":\"ap-beijing\",\"qcloudAppId\":\"1259572200\",\"qcloudBucketName\":\"mwy-1259572200\",\"qcloudDomain\":\"https://mwy-1259572200.cos.ap-beijing.myqcloud.com\",\"qcloudPrefix\":\"mwy\",\"qcloudSecretId\":\"AKIDuZ1ylk521ztauyHTyEFCsLcnskYCnW4N\",\"qcloudSecretKey\":\"DYghbggfpu6sU5aAaq66HRJkuLeqrnKl\",\"type\":2}\r\n', 1, '云存储配置信息', '2019-07-03 11:05:29', '2019-07-03 11:05:32');
INSERT INTO `sys_config` VALUES (2, 'FTP_CONFIG_KEY', '{\"ftpIp\":\"192.168.226.128\",\"ftpPort\":\"21\",\"ftpUsername\":\"uftp\",\"ftpPassword\":\"qweasdzxc\",\"imgPath\":\"img/\",\"videoPath\":\"video/\",\"coursePath\":\"course/\"}', 1, 'ftp配置信息', '2019-07-22 17:41:24', '2019-07-22 17:41:28');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID，一级部门为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, '腾讯', 0, 0, '2018-12-18 21:43:48', '2019-07-16 14:10:19');
INSERT INTO `sys_dept` VALUES (2, 1, '北京分公司', 0, 0, '2018-12-22 23:28:09', '2019-07-16 14:06:55');
INSERT INTO `sys_dept` VALUES (3, 1, '上海公司', 1, 0, '2018-12-22 23:28:14', '2019-07-16 14:06:59');
INSERT INTO `sys_dept` VALUES (4, 3, '技术部', 0, 0, '2018-12-22 23:28:18', '2019-07-16 14:07:16');
INSERT INTO `sys_dept` VALUES (5, 2, '销售部', 0, 0, '2018-12-22 23:28:23', '2019-07-16 14:07:04');
INSERT INTO `sys_dept` VALUES (6, 2, '技术部', 1, 0, '2018-12-22 15:27:54', '2019-07-16 14:07:09');
INSERT INTO `sys_dept` VALUES (7, 0, '阿里巴巴责任有限公司', 1, 0, '2019-07-16 13:48:09', '2019-07-16 14:10:24');
INSERT INTO `sys_dept` VALUES (8, 7, '支付宝', 0, 0, '2019-07-16 13:49:02', '2019-07-16 14:07:43');
INSERT INTO `sys_dept` VALUES (9, 8, '花呗', 0, 0, '2019-07-16 14:07:57', '2019-07-16 14:07:57');
INSERT INTO `sys_dept` VALUES (14, 7, '淘宝', 1, 0, '2019-07-17 17:35:31', '2019-07-17 17:35:31');
INSERT INTO `sys_dept` VALUES (15, 14, '技术部', 0, 0, '2019-07-17 17:35:58', '2019-07-17 17:35:58');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pid` bigint(20) NULL DEFAULT NULL COMMENT '父级字典',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (16, 0, '状态', '', 'frozen', 1, '2019-04-12 10:50:21', '2019-04-13 07:30:04');
INSERT INTO `sys_dict` VALUES (17, 16, '启用', NULL, '1', 1, '2019-04-12 10:50:25', '2019-04-12 10:50:28');
INSERT INTO `sys_dict` VALUES (18, 16, '禁用', NULL, '0', 2, '2019-04-12 10:50:30', '2019-04-12 10:50:33');
INSERT INTO `sys_dict` VALUES (29, 0, '性别', '', 'sex', 2, '2019-04-12 10:50:36', '2019-04-13 07:29:59');
INSERT INTO `sys_dict` VALUES (30, 29, '男', NULL, '1', 1, '2019-04-12 10:50:41', '2019-04-12 10:50:43');
INSERT INTO `sys_dict` VALUES (31, 29, '女', NULL, '2', 2, '2019-04-12 10:50:46', '2019-04-12 10:50:48');
INSERT INTO `sys_dict` VALUES (32, 0, '菜单类型', NULL, 'menu_type', 3, '2019-04-12 18:30:54', '2019-04-12 18:30:57');
INSERT INTO `sys_dict` VALUES (33, 32, '目录', NULL, '0', 1, '2019-04-12 18:31:48', '2019-04-12 18:31:50');
INSERT INTO `sys_dict` VALUES (34, 32, '菜单', NULL, '1', 2, '2019-04-12 18:32:10', '2019-04-12 18:32:12');
INSERT INTO `sys_dict` VALUES (35, 32, '按钮', NULL, '2', 3, '2019-04-12 18:32:25', '2019-04-12 18:32:28');
INSERT INTO `sys_dict` VALUES (36, 0, '定时任务状态', NULL, 'schedule_status', 4, '2019-04-13 11:49:28', '2019-04-13 11:49:30');
INSERT INTO `sys_dict` VALUES (37, 36, '正常', NULL, '1', 1, '2019-04-13 11:50:08', '2019-04-13 11:50:10');
INSERT INTO `sys_dict` VALUES (38, 36, '暂停', NULL, '0', 2, '2019-04-13 11:50:24', '2019-04-13 11:50:27');
INSERT INTO `sys_dict` VALUES (39, 0, '顶级', '顶级', NULL, 0, '2019-04-13 15:55:58', '2019-04-13 15:56:01');

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息',
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150667819491475817 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登陆日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO `sys_login_log` VALUES (1150667819491475800, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 10:01:11', '2019-08-06 10:01:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475801, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 10:01:14', '2019-08-06 10:01:14');
INSERT INTO `sys_login_log` VALUES (1150667819491475802, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 13:45:46', '2019-08-06 13:45:46');
INSERT INTO `sys_login_log` VALUES (1150667819491475803, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 15:31:56', '2019-08-06 15:31:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475804, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 08:37:55', '2019-08-07 08:37:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475805, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 13:39:40', '2019-08-07 13:39:40');
INSERT INTO `sys_login_log` VALUES (1150667819491475806, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 16:16:13', '2019-08-07 16:16:13');
INSERT INTO `sys_login_log` VALUES (1150667819491475807, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 16:16:18', '2019-08-07 16:16:18');
INSERT INTO `sys_login_log` VALUES (1150667819491475808, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 17:56:22', '2019-08-07 17:56:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475809, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 17:56:24', '2019-08-07 17:56:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475810, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 09:32:55', '2019-08-08 09:32:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475811, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 13:47:07', '2019-08-08 13:47:07');
INSERT INTO `sys_login_log` VALUES (1150667819491475812, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 14:29:37', '2019-08-08 14:29:37');
INSERT INTO `sys_login_log` VALUES (1150667819491475813, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:28:53', '2019-08-08 17:28:53');
INSERT INTO `sys_login_log` VALUES (1150667819491475814, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:30:30', '2019-08-08 17:30:30');
INSERT INTO `sys_login_log` VALUES (1150667819491475815, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:30:32', '2019-08-08 17:30:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475816, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 08:50:45', '2019-08-09 08:50:45');
INSERT INTO `sys_login_log` VALUES (1150667819491475817, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 10:43:11', '2019-08-09 10:43:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475818, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 10:43:24', '2019-08-09 10:43:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475819, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 13:37:52', '2019-08-09 13:37:52');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统首页', 'dashboard', 'sys:dashboard:info', 1, 'el-icon-lx-home', 0, 1, 1, '2018-12-06 14:54:07', '2018-12-06 14:54:09', 0);
INSERT INTO `sys_menu` VALUES (2, 0, '系统管理', 'sys', '', 0, 'el-icon-lx-settings', 15, 1, 1, '2018-12-10 17:52:34', '2018-12-10 17:52:37', 0);
INSERT INTO `sys_menu` VALUES (3, 2, '用户管理', 'sysuser', 'sys:user:list', 1, NULL, 16, 1, 1, '2018-12-10 18:28:59', '2019-01-02 10:38:09', 0);
INSERT INTO `sys_menu` VALUES (4, 2, '角色管理', 'sysrole', 'sys:role:list', 1, NULL, 17, 1, 1, '2018-12-10 18:35:34', '2019-01-03 01:33:09', 0);
INSERT INTO `sys_menu` VALUES (5, 2, '菜单管理', 'sysmenu', 'sys:menu:list', 1, NULL, 18, 1, 1, '2018-12-10 18:36:16', '2019-01-03 01:39:01', 0);
INSERT INTO `sys_menu` VALUES (6, 2, '企业管理', 'sysdept', 'sys:dept:list', 1, NULL, 19, 1, 1, '2018-12-10 18:37:20', '2019-01-03 01:41:49', 0);
INSERT INTO `sys_menu` VALUES (7, 2, '定时任务', 'sysschedule', 'sys:schedule:list', 1, NULL, 21, 1, 1, '2018-12-10 18:39:14', '2019-01-03 01:42:33', 0);
INSERT INTO `sys_menu` VALUES (8, 2, '字典管理', 'sysdict', 'sys:dict:list', 1, NULL, 24, NULL, NULL, '2019-04-13 07:10:28', '2019-04-15 07:18:41', 0);
INSERT INTO `sys_menu` VALUES (10, 2, '登陆日志', 'sysloginlog', 'sys:loginLog:list', 1, NULL, 22, NULL, NULL, '2019-04-12 07:26:22', '2019-04-15 07:14:49', 0);
INSERT INTO `sys_menu` VALUES (11, 2, '操作日志', 'sysoperationlog', 'sys:operationLog:list', 1, NULL, 23, NULL, NULL, '2019-04-12 08:07:19', '2019-04-15 07:18:14', 0);
INSERT INTO `sys_menu` VALUES (12, 3, '新增', 'sys/user/add', 'sys:user:add', 2, NULL, 1, NULL, NULL, '2019-01-02 10:35:57', '2019-06-27 17:35:21', 0);
INSERT INTO `sys_menu` VALUES (13, 3, '删除', 'sys/user/del', 'sys:user:del', 2, NULL, 3, NULL, NULL, '2019-01-02 10:38:50', '2019-06-27 17:34:58', 0);
INSERT INTO `sys_menu` VALUES (14, 3, '重置密码', 'sys/user/reset/password', 'sys:user:resetPassword', 2, NULL, 4, NULL, NULL, '2019-01-03 01:26:19', '2019-06-27 17:34:47', 0);
INSERT INTO `sys_menu` VALUES (15, 3, '修改密码', 'sys/user/change/password', 'sys:user:changePassword', 2, NULL, 5, NULL, NULL, '2019-01-03 01:27:06', '2019-06-27 17:34:38', 0);
INSERT INTO `sys_menu` VALUES (16, 3, '编辑', 'sys/user/edit', 'sys:user:edit', 2, NULL, 2, NULL, NULL, '2019-06-27 17:36:01', '2019-06-27 17:36:01', 0);
INSERT INTO `sys_menu` VALUES (17, 3, '清除缓存', 'sys/user/clearCache', 'sys:user:clearCache', 2, NULL, 6, NULL, NULL, '2019-06-28 10:51:11', '2019-06-28 10:51:37', 0);
INSERT INTO `sys_menu` VALUES (18, 4, '新增', 'sys/role/add', 'sys:role:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:30:55', '2019-06-27 17:37:17', 0);
INSERT INTO `sys_menu` VALUES (19, 4, '删除', 'sys/role/del', 'sys:role:del', 2, NULL, 3, NULL, NULL, '2019-01-03 01:31:49', '2019-06-27 17:36:30', 0);
INSERT INTO `sys_menu` VALUES (20, 4, '权限配置', 'sys/role/configPerm', 'sys:role:configPerm', 2, NULL, 4, NULL, NULL, '2019-01-03 01:32:42', '2019-06-27 17:36:22', 0);
INSERT INTO `sys_menu` VALUES (21, 4, '编辑', 'sys/role/edit', 'sys:role:edit', 2, NULL, 2, NULL, NULL, '2019-06-27 17:37:02', '2019-06-27 17:37:02', 0);
INSERT INTO `sys_menu` VALUES (22, 5, '新增', 'sys/menu/add', 'sys:menu:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:37:40', '2019-06-27 17:37:53', 0);
INSERT INTO `sys_menu` VALUES (23, 5, '删除', 'sys/menu/del', 'sys:menu:del', 2, NULL, 2, NULL, NULL, '2019-01-03 01:38:13', '2019-04-15 07:22:48', 0);
INSERT INTO `sys_menu` VALUES (24, 5, '编辑', 'sys/menu/edit', 'sys:menu:edit', 2, NULL, 3, NULL, NULL, '2019-01-03 01:38:47', '2019-04-15 07:22:54', 0);
INSERT INTO `sys_menu` VALUES (25, 6, '编辑', 'sys/dept/edit', 'sys:dept:edit', 2, NULL, 3, NULL, NULL, '2019-01-03 01:41:23', '2019-04-15 07:23:13', 0);
INSERT INTO `sys_menu` VALUES (26, 6, '新增', 'sys/dept/add', 'sys:dept:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:39:55', '2019-07-15 11:14:21', 0);
INSERT INTO `sys_menu` VALUES (27, 6, '删除', 'sys/dept/del', 'sys:dept:del', 2, NULL, 2, NULL, NULL, '2019-01-03 01:40:57', '2019-04-15 07:23:07', 0);
INSERT INTO `sys_menu` VALUES (28, 7, '删除', 'sys/schedule/del', 'sys:schedule:del', 2, NULL, 3, NULL, NULL, '2019-01-03 01:44:42', '2019-04-15 07:23:44', 0);
INSERT INTO `sys_menu` VALUES (29, 7, '新增', 'sys/schedule/add', 'sys:schedule:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:43:30', '2019-04-15 07:23:35', 0);
INSERT INTO `sys_menu` VALUES (30, 7, '修改', 'sys/schedule/edit', 'sys:schedule:edit', 2, NULL, 2, NULL, NULL, '2019-01-03 01:44:03', '2019-04-15 07:23:28', 0);
INSERT INTO `sys_menu` VALUES (31, 7, '运行一次', 'sys/schedule/run', 'sys:schedule:run', 2, NULL, 4, NULL, NULL, '2019-06-28 10:36:50', '2019-06-28 10:36:50', 0);
INSERT INTO `sys_menu` VALUES (32, 7, '停止', 'sys/schedule/pause', 'sys:schedule:pause', 2, NULL, 5, NULL, NULL, '2019-06-28 10:37:31', '2019-06-28 10:37:31', 0);
INSERT INTO `sys_menu` VALUES (33, 7, '恢复', 'sys/schedule/resume', 'sys:schedule:resume', 2, NULL, 6, NULL, NULL, '2019-06-28 10:38:07', '2019-06-28 10:38:07', 0);
INSERT INTO `sys_menu` VALUES (34, 10, '清空日志', 'sys/loginLog/clear', 'sys:loginLog:clear', 2, NULL, 1, NULL, NULL, '2019-04-15 07:25:37', '2019-04-15 07:25:37', 0);
INSERT INTO `sys_menu` VALUES (35, 11, '清空日志', 'sys/operationLog/clear', 'sys:operationLog:clear', 2, NULL, 2, NULL, NULL, '2019-04-15 07:27:08', '2019-04-15 07:27:08', 0);
INSERT INTO `sys_menu` VALUES (36, 8, '查看字典', 'sys/dict/info', 'sys:dict:info', 2, NULL, 4, NULL, NULL, '2019-06-28 10:45:47', '2019-06-28 10:45:47', 0);
INSERT INTO `sys_menu` VALUES (37, 8, '新增', 'sys/dict/add', 'sys:dict:add', 2, NULL, 1, NULL, NULL, '2019-04-15 07:19:26', '2019-04-15 07:24:11', 0);
INSERT INTO `sys_menu` VALUES (38, 8, '删除', 'sys/dict/delete', 'sys:dict:del', 2, NULL, 2, NULL, NULL, '2019-04-15 07:20:14', '2019-04-15 07:24:16', 0);
INSERT INTO `sys_menu` VALUES (39, 8, '编辑', 'sys/dict/edit', 'sys:dict:edit', 2, NULL, 3, NULL, NULL, '2019-06-28 10:44:41', '2019-06-28 10:44:41', 0);
INSERT INTO `sys_menu` VALUES (40, 0, '会议管理', 'meeting', '', 0, 'el-icon-notebook-1', 30, NULL, NULL, '2019-06-17 14:07:41', '2019-07-17 13:39:53', 0);
INSERT INTO `sys_menu` VALUES (41, 40, '会议列表', 'meetingdetail', 'meeting:detail:list', 1, NULL, 31, NULL, NULL, '2019-06-19 16:21:49', '2019-06-19 16:22:13', 0);
INSERT INTO `sys_menu` VALUES (42, 40, '会议课件', 'meetingcourse', 'meeting:course:list', 1, NULL, 32, NULL, NULL, '2019-06-28 16:52:43', '2019-06-28 16:58:29', 0);
INSERT INTO `sys_menu` VALUES (43, 40, '会议场所', 'meetingplace', 'meeting:place:list', 1, NULL, 33, NULL, NULL, '2019-06-28 16:56:22', '2019-06-28 16:56:22', 0);
INSERT INTO `sys_menu` VALUES (44, 40, '会议问卷', 'meetingquestion', 'meeting:question:list', 1, NULL, 34, NULL, NULL, '2019-06-28 16:58:06', '2019-06-28 16:58:06', 0);
INSERT INTO `sys_menu` VALUES (45, 41, '导出', 'meeting/detail/export', 'meeting:detail:export', 2, NULL, 1, NULL, NULL, '2019-06-27 15:46:49', '2019-07-11 11:00:23', 0);
INSERT INTO `sys_menu` VALUES (46, 41, '查看', 'meeting/detail/info', 'meeting:detail:info', 2, NULL, 2, NULL, NULL, '2019-06-27 15:59:08', '2019-07-11 11:00:28', 0);
INSERT INTO `sys_menu` VALUES (47, 42, '上传', 'meeting/course/ftpUpload', 'meeting:course:ftpUpload', 2, NULL, 1, NULL, NULL, '2019-07-11 10:59:30', '2019-07-11 10:59:58', 0);
INSERT INTO `sys_menu` VALUES (48, 42, '下载', 'meeting/course/download', 'meeting:course:download', 2, NULL, 2, NULL, NULL, '2019-07-11 13:27:44', '2019-07-11 13:27:44', 0);
INSERT INTO `sys_menu` VALUES (49, 42, '删除', 'meeting/course/del', 'meeting:course:del', 2, NULL, 3, NULL, NULL, '2019-07-11 13:28:18', '2019-07-11 13:28:18', 0);
INSERT INTO `sys_menu` VALUES (50, 0, '医生管理', 'docker', '', 0, 'el-icon-first-aid-kit', 40, NULL, NULL, '2019-06-28 17:31:58', '2019-07-17 13:40:00', 0);
INSERT INTO `sys_menu` VALUES (51, 50, '医生列表', 'dockerdetail', 'docker:detail:list', 1, NULL, 41, NULL, NULL, '2019-06-28 17:33:54', '2019-06-28 17:33:54', 0);
INSERT INTO `sys_menu` VALUES (52, 50, '医院列表', 'hospitaldetail', 'hospital:detail:list', 1, NULL, 42, NULL, NULL, '2019-06-28 17:34:48', '2019-06-28 17:34:48', 0);
INSERT INTO `sys_menu` VALUES (57, 0, '用户管理', 'user', NULL, 0, 'el-icon-user', 50, NULL, NULL, '2019-08-05 10:33:48', '2019-08-05 10:34:45', 0);
INSERT INTO `sys_menu` VALUES (58, 57, '用户列表', 'userdetail', 'user:detail:list', 1, NULL, 51, NULL, NULL, '2019-08-05 10:54:05', '2019-08-05 10:54:05', 0);
INSERT INTO `sys_menu` VALUES (59, 57, '区域管理', 'userarea', 'user:area:list', 1, NULL, 52, NULL, NULL, '2019-08-05 10:55:35', '2019-08-05 10:55:35', 0);
INSERT INTO `sys_menu` VALUES (60, 57, '角色管理', 'userrole', 'user:role:list', 1, NULL, 53, NULL, NULL, '2019-08-05 10:56:12', '2019-08-05 10:56:12', 0);
INSERT INTO `sys_menu` VALUES (61, 57, '权限管理', 'userpermissions', 'user:permissions:list', 1, NULL, 54, NULL, NULL, '2019-08-05 10:57:33', '2019-08-05 10:57:33', 0);
INSERT INTO `sys_menu` VALUES (64, 58, '新增', 'user/detail/add', 'user:detail:add', 2, NULL, 1, NULL, NULL, '2019-08-05 15:52:24', '2019-08-05 15:52:24', 0);
INSERT INTO `sys_menu` VALUES (65, 58, '编辑', 'user/detail/edit', 'user:detail:edit', 2, NULL, 2, NULL, NULL, '2019-08-05 15:52:50', '2019-08-05 15:52:50', 0);
INSERT INTO `sys_menu` VALUES (66, 58, '删除', 'user/detail/del', 'user:detail:del', 2, NULL, 3, NULL, NULL, '2019-08-05 15:53:18', '2019-08-05 15:53:18', 0);
INSERT INTO `sys_menu` VALUES (67, 58, '导出', 'user/detail/export', 'user:detail:export', 2, NULL, 4, NULL, NULL, '2019-08-05 15:53:48', '2019-08-05 15:53:48', 0);
INSERT INTO `sys_menu` VALUES (68, 59, '新增', 'user/area/add', 'user:area:add', 2, NULL, 1, NULL, NULL, '2019-08-06 10:06:28', '2019-08-06 10:06:28', 0);
INSERT INTO `sys_menu` VALUES (69, 59, '编辑', 'user/area/edit', 'user:area:edit', 2, NULL, 2, NULL, NULL, '2019-08-06 10:06:59', '2019-08-06 10:06:59', 0);
INSERT INTO `sys_menu` VALUES (70, 59, '删除', 'user/area/del', 'user:area:del', 2, NULL, 3, NULL, NULL, '2019-08-06 10:07:21', '2019-08-06 10:07:21', 0);
INSERT INTO `sys_menu` VALUES (71, 60, '新增', 'user/role/dd', 'user:role:add', 2, NULL, 1, NULL, NULL, '2019-08-06 10:08:25', '2019-08-06 10:08:25', 0);
INSERT INTO `sys_menu` VALUES (72, 60, '编辑', 'user/role/edit', 'user:role:edit', 2, NULL, 2, NULL, NULL, '2019-08-06 10:08:50', '2019-08-06 10:08:50', 0);
INSERT INTO `sys_menu` VALUES (73, 60, '删除', 'user/role/del', 'user:role:del', 2, NULL, 3, NULL, NULL, '2019-08-06 10:09:12', '2019-08-06 10:09:12', 0);

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志类型',
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类名称',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名称',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `execute_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行时间(毫秒)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150601874915967519 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------
INSERT INTO `sys_operation_log` VALUES (1150601874915967396, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-08-06 08:49:20', '2019-08-06 08:49:20', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967397, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-08-06 08:52:13', '2019-08-06 08:52:13', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967398, '操作日志', '会议列表分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:54:14', '2019-08-06 08:54:14', '172');
INSERT INTO `sys_operation_log` VALUES (1150601874915967399, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:54:25', '2019-08-06 08:54:25', '174');
INSERT INTO `sys_operation_log` VALUES (1150601874915967400, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:54:55', '2019-08-06 08:54:55', '28');
INSERT INTO `sys_operation_log` VALUES (1150601874915967401, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:54:56', '2019-08-06 08:54:56', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967402, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:55:05', '2019-08-06 08:55:05', '23');
INSERT INTO `sys_operation_log` VALUES (1150601874915967403, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 08:59:10', '2019-08-06 08:59:10', '954');
INSERT INTO `sys_operation_log` VALUES (1150601874915967404, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:03:55', '2019-08-06 09:03:55', '127');
INSERT INTO `sys_operation_log` VALUES (1150601874915967405, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'.*, a.area_name, r.role_name\n        from user_detail u\n        left join user_a\' at line 2\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\UserDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select case u.status when 1 then \'正常\' else \'锁定\' end         u.*, a.area_name, r.role_name         from user_detail u         left join user_area a on a.id = u.area_id         left join user_role r on r.id = u.role_id          WHERE 1 = 1          order by u.create_time desc\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'.*, a.area_name, r.role_name\n        from user_detail u\n        left join user_a\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'.*, a.area_name, r.role_name\n        from user_detail u\n        left join user_a\' at line 2', '2019-08-06 09:03:58', '2019-08-06 09:03:58', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967406, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:04:44', '2019-08-06 09:04:44', '490');
INSERT INTO `sys_operation_log` VALUES (1150601874915967407, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:07:54', '2019-08-06 09:07:54', '400');
INSERT INTO `sys_operation_log` VALUES (1150601874915967408, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:11:56', '2019-08-06 09:11:56', '271');
INSERT INTO `sys_operation_log` VALUES (1150601874915967409, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:12:01', '2019-08-06 09:12:01', '56');
INSERT INTO `sys_operation_log` VALUES (1150601874915967410, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:43:46', '2019-08-06 09:43:46', '386');
INSERT INTO `sys_operation_log` VALUES (1150601874915967411, '操作日志', '会议列表分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:47:38', '2019-08-06 09:47:38', '151');
INSERT INTO `sys_operation_log` VALUES (1150601874915967412, '操作日志', '会议课件分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":5}', '2019-08-06 09:47:41', '2019-08-06 09:47:41', '107');
INSERT INTO `sys_operation_log` VALUES (1150601874915967413, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 09:47:46', '2019-08-06 09:47:46', '32');
INSERT INTO `sys_operation_log` VALUES (1150601874915967414, '操作日志', '会议课件分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":5}', '2019-08-06 09:48:00', '2019-08-06 09:48:00', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967415, '操作日志', '会议课件分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":5}', '2019-08-06 09:48:07', '2019-08-06 09:48:07', '29');
INSERT INTO `sys_operation_log` VALUES (1150601874915967416, '操作日志', '会议课件分页', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":5}', '2019-08-06 09:59:43', '2019-08-06 09:59:43', '63');
INSERT INTO `sys_operation_log` VALUES (1150601874915967417, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'area\' not found. Available parameters are [page, userArea, param1, param2]', '2019-08-06 09:59:46', '2019-08-06 09:59:46', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967418, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'area\' not found. Available parameters are [page, userArea, param1, param2]', '2019-08-06 10:01:18', '2019-08-06 10:01:18', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967419, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:05:35', '2019-08-06 10:05:35', '126');
INSERT INTO `sys_operation_log` VALUES (1150601874915967420, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:05:54', '2019-08-06 10:05:54', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967421, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:09:25', '2019-08-06 10:09:25', '25');
INSERT INTO `sys_operation_log` VALUES (1150601874915967422, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:09:50', '2019-08-06 10:09:50', '11');
INSERT INTO `sys_operation_log` VALUES (1150601874915967423, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:16:06', '2019-08-06 10:16:06', '45');
INSERT INTO `sys_operation_log` VALUES (1150601874915967424, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:29:32', '2019-08-06 10:29:32', '59');
INSERT INTO `sys_operation_log` VALUES (1150601874915967425, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:30:04', '2019-08-06 10:30:04', '22');
INSERT INTO `sys_operation_log` VALUES (1150601874915967426, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:31:52', '2019-08-06 10:31:52', '47');
INSERT INTO `sys_operation_log` VALUES (1150601874915967427, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:32:19', '2019-08-06 10:32:19', '44');
INSERT INTO `sys_operation_log` VALUES (1150601874915967428, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:32:49', '2019-08-06 10:32:49', '33');
INSERT INTO `sys_operation_log` VALUES (1150601874915967429, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:33:28', '2019-08-06 10:33:28', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967430, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:33:39', '2019-08-06 10:33:39', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967431, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:44:34', '2019-08-06 10:44:34', '78');
INSERT INTO `sys_operation_log` VALUES (1150601874915967432, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:44:42', '2019-08-06 10:44:42', '101');
INSERT INTO `sys_operation_log` VALUES (1150601874915967433, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 10:46:41', '2019-08-06 10:46:41', '26');
INSERT INTO `sys_operation_log` VALUES (1150601874915967434, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:04:12', '2019-08-06 11:04:12', '40');
INSERT INTO `sys_operation_log` VALUES (1150601874915967435, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:05:50', '2019-08-06 11:05:50', '60');
INSERT INTO `sys_operation_log` VALUES (1150601874915967436, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:06:13', '2019-08-06 11:06:13', '95');
INSERT INTO `sys_operation_log` VALUES (1150601874915967437, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:12:13', '2019-08-06 11:12:13', '51');
INSERT INTO `sys_operation_log` VALUES (1150601874915967438, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:27:28', '2019-08-06 11:27:28', '125');
INSERT INTO `sys_operation_log` VALUES (1150601874915967439, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:28:00', '2019-08-06 11:28:00', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967440, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:28:51', '2019-08-06 11:28:51', '25');
INSERT INTO `sys_operation_log` VALUES (1150601874915967441, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:32:45', '2019-08-06 11:32:45', '92');
INSERT INTO `sys_operation_log` VALUES (1150601874915967442, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"level\":1,\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:32:49', '2019-08-06 11:32:49', '17');
INSERT INTO `sys_operation_log` VALUES (1150601874915967443, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:32:53', '2019-08-06 11:32:53', '9');
INSERT INTO `sys_operation_log` VALUES (1150601874915967444, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"level\":2,\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:34:33', '2019-08-06 11:34:33', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967445, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 11:34:35', '2019-08-06 11:34:35', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967446, '操作日志', '用户列表分页', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 13:46:22', '2019-08-06 13:46:22', '132');
INSERT INTO `sys_operation_log` VALUES (1150601874915967447, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 13:46:25', '2019-08-06 13:46:25', '42');
INSERT INTO `sys_operation_log` VALUES (1150601874915967448, '操作日志', '区域分页', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-06 13:51:03', '2019-08-06 13:51:03', '16');
INSERT INTO `sys_operation_log` VALUES (1150601874915967449, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 08:43:31', '2019-08-07 08:43:31', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967450, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 08:43:32', '2019-08-07 08:43:32', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967451, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 08:43:33', '2019-08-07 08:43:33', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967452, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 08:43:34', '2019-08-07 08:43:34', '1');
INSERT INTO `sys_operation_log` VALUES (1150601874915967453, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 09:09:11', '2019-08-07 09:09:11', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967454, '异常日志', '', 1, NULL, NULL, '失败', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Long\'; nested exception is java.lang.NumberFormatException: For input string: \"3|三级\"', '2019-08-07 10:20:56', '2019-08-07 10:20:56', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967455, '异常日志', '', 1, NULL, NULL, '失败', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Long\'; nested exception is java.lang.NumberFormatException: For input string: \"3|三级\"', '2019-08-07 10:22:08', '2019-08-07 10:22:08', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967456, '异常日志', '', 1, NULL, NULL, '失败', 'Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Long\'; nested exception is java.lang.NumberFormatException: For input string: \"4|四级\"', '2019-08-07 10:23:29', '2019-08-07 10:23:29', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967457, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 11:18:11', '2019-08-07 11:18:11', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967458, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 11:18:13', '2019-08-07 11:18:13', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967459, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"currentPage\":0,\"pageSize\":10}', '2019-08-07 11:18:14', '2019-08-07 11:18:14', '1');
INSERT INTO `sys_operation_log` VALUES (1150601874915967460, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":9,\"createTime\":\"Aug 7, 2019 3:59:05 PM\",\"updateTime\":\"Aug 7, 2019 3:59:05 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 15:59:06', '2019-08-07 15:59:06', '26');
INSERT INTO `sys_operation_log` VALUES (1150601874915967461, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":10,\"createTime\":\"Aug 7, 2019 4:02:30 PM\",\"updateTime\":\"Aug 7, 2019 4:02:30 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:02:30', '2019-08-07 16:02:30', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967462, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":11,\"createTime\":\"Aug 7, 2019 4:06:45 PM\",\"updateTime\":\"Aug 7, 2019 4:06:45 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:06:46', '2019-08-07 16:06:46', '8295');
INSERT INTO `sys_operation_log` VALUES (1150601874915967463, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":12,\"createTime\":\"Aug 7, 2019 4:09:07 PM\",\"updateTime\":\"Aug 7, 2019 4:09:07 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:09:08', '2019-08-07 16:09:08', '25');
INSERT INTO `sys_operation_log` VALUES (1150601874915967464, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'topLevel\' not found. Available parameters are [arg2, arg1, arg0, param3, param1, param2]', '2019-08-07 16:16:54', '2019-08-07 16:16:54', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967465, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'topLevel\' not found. Available parameters are [arg2, arg1, arg0, param3, param1, param2]', '2019-08-07 16:23:44', '2019-08-07 16:23:44', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967466, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":13,\"parentId\":2,\"areaName\":\"丰台区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"1/2\",\"createTime\":\"Aug 7, 2019 4:41:40 PM\",\"updateTime\":\"Aug 7, 2019 4:41:40 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:41:41', '2019-08-07 16:41:41', '73');
INSERT INTO `sys_operation_log` VALUES (1150601874915967467, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":14,\"parentId\":0,\"areaName\":\"木叶\",\"level\":1,\"levelName\":\"一级\",\"createTime\":\"Aug 7, 2019 4:47:29 PM\",\"updateTime\":\"Aug 7, 2019 4:47:29 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:47:30', '2019-08-07 16:47:30', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967468, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":15,\"parentId\":14,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"/木叶\",\"optionIds\":\"/14\",\"createTime\":\"Aug 7, 2019 4:47:58 PM\",\"updateTime\":\"Aug 7, 2019 4:47:58 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:47:59', '2019-08-07 16:47:59', '11');
INSERT INTO `sys_operation_log` VALUES (1150601874915967469, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":16,\"parentId\":14,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"/木叶\",\"optionIds\":\"/14\",\"createTime\":\"Aug 7, 2019 4:58:03 PM\",\"updateTime\":\"Aug 7, 2019 4:58:03 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:58:04', '2019-08-07 16:58:04', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967470, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":17,\"parentId\":14,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"createTime\":\"Aug 7, 2019 4:58:58 PM\",\"updateTime\":\"Aug 7, 2019 4:58:58 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 16:58:58', '2019-08-07 16:58:58', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967471, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":18,\"parentId\":14,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"木叶\",\"optionIds\":\"14\",\"createTime\":\"Aug 7, 2019 5:07:33 PM\",\"updateTime\":\"Aug 7, 2019 5:07:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 17:07:34', '2019-08-07 17:07:34', '21');
INSERT INTO `sys_operation_log` VALUES (1150601874915967472, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":19,\"parentId\":18,\"areaName\":\"鸣人家\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"木叶/火之国\",\"optionIds\":\"14/18\",\"createTime\":\"Aug 7, 2019 5:11:17 PM\",\"updateTime\":\"Aug 7, 2019 5:11:17 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 17:11:18', '2019-08-07 17:11:18', '23');
INSERT INTO `sys_operation_log` VALUES (1150601874915967473, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":20,\"parentId\":1,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"1\",\"createTime\":\"Aug 7, 2019 5:12:19 PM\",\"updateTime\":\"Aug 7, 2019 5:12:19 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 17:12:20', '2019-08-07 17:12:20', '8');
INSERT INTO `sys_operation_log` VALUES (1150601874915967474, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":18,\"parentId\":1,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"1\",\"createTime\":\"Aug 7, 2019 5:07:34 PM\",\"updateTime\":\"Aug 7, 2019 5:15:00 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 17:15:00', '2019-08-07 17:15:00', '206');
INSERT INTO `sys_operation_log` VALUES (1150601874915967475, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":18,\"parentId\":14,\"areaName\":\"火之国\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"木叶\",\"optionIds\":\"14\",\"createTime\":\"Aug 7, 2019 5:07:34 PM\",\"updateTime\":\"Aug 7, 2019 5:15:19 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-07 17:15:19', '2019-08-07 17:15:19', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967476, '异常日志', '', 1, NULL, NULL, '失败', 'Mapper method \'com.ksh.beam.system.dao.UserAreaMapper.getMaxLevel attempted to return null from a method with a primitive return type (int).', '2019-08-08 10:33:27', '2019-08-08 10:33:27', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967477, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-08-08 10:42:50', '2019-08-08 10:42:50', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967478, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":21,\"parentId\":0,\"areaName\":\"全国\",\"level\":1,\"levelName\":\"一级\",\"createTime\":\"Aug 8, 2019 10:49:05 AM\",\"updateTime\":\"Aug 8, 2019 10:49:05 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 10:49:06', '2019-08-08 10:49:06', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967479, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":21,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"21\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 10:51:10 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 10:51:10', '2019-08-08 10:51:10', '12');
INSERT INTO `sys_operation_log` VALUES (1150601874915967480, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":23,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:28 AM\",\"updateTime\":\"Aug 8, 2019 10:51:28 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 10:51:28', '2019-08-08 10:51:28', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967481, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":24,\"parentId\":0,\"areaName\":\"美国\",\"level\":1,\"levelName\":\"一级\",\"createTime\":\"Aug 8, 2019 10:53:36 AM\",\"updateTime\":\"Aug 8, 2019 10:53:36 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 10:53:37', '2019-08-08 10:53:37', '8');
INSERT INTO `sys_operation_log` VALUES (1150601874915967482, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":25,\"parentId\":24,\"areaName\":\"屌丝\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"createTime\":\"Aug 8, 2019 11:08:16 AM\",\"updateTime\":\"Aug 8, 2019 11:08:16 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 11:08:17', '2019-08-08 11:08:17', '22685');
INSERT INTO `sys_operation_log` VALUES (1150601874915967483, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":26,\"parentId\":24,\"areaName\":\"wqe\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"createTime\":\"Aug 8, 2019 11:09:52 AM\",\"updateTime\":\"Aug 8, 2019 11:09:52 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 11:09:52', '2019-08-08 11:09:52', '41680');
INSERT INTO `sys_operation_log` VALUES (1150601874915967484, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'id\' not found. Available parameters are [level, topLevel, param3, param1, parentId, param2]', '2019-08-08 11:24:50', '2019-08-08 11:24:50', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967485, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":27,\"parentId\":24,\"areaName\":\"zxczczxc\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"createTime\":\"Aug 8, 2019 11:27:20 AM\",\"updateTime\":\"Aug 8, 2019 11:27:20 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 11:27:20', '2019-08-08 11:27:20', '11819');
INSERT INTO `sys_operation_log` VALUES (1150601874915967486, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"parentId\":24,\"areaName\":\"asdasdas\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 11:28:04', '2019-08-08 11:28:04', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967487, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"parentId\":24,\"areaName\":\"asdasdas\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 11:28:09', '2019-08-08 11:28:09', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967488, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[23]', '2019-08-08 13:47:17', '2019-08-08 13:47:17', '40');
INSERT INTO `sys_operation_log` VALUES (1150601874915967489, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:48:18 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 13:48:19', '2019-08-08 13:48:19', '24');
INSERT INTO `sys_operation_log` VALUES (1150601874915967490, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":21,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"21\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:48:47 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 13:48:47', '2019-08-08 13:48:47', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967491, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":21,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"21\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:52:39 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 13:52:39', '2019-08-08 13:52:39', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967492, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":22,\"areaName\":\"北京\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:57:01 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 13:57:01', '2019-08-08 13:57:01', '232493');
INSERT INTO `sys_operation_log` VALUES (1150601874915967493, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":22,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:57:01 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:07:21', '2019-08-08 14:07:21', '5050');
INSERT INTO `sys_operation_log` VALUES (1150601874915967494, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":22,\"areaName\":\"北京\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:57:01 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:08:43', '2019-08-08 14:08:43', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967495, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":22,\"parentId\":22,\"areaName\":\"北京\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 10:51:10 AM\",\"updateTime\":\"Aug 8, 2019 1:57:01 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:08:50', '2019-08-08 14:08:50', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967496, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"parentId\":24,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"美国\",\"optionIds\":\"24\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:17:34', '2019-08-08 14:17:34', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967497, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:42 PM\",\"updateTime\":\"Aug 8, 2019 2:17:42 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:17:43', '2019-08-08 14:17:43', '42');
INSERT INTO `sys_operation_log` VALUES (1150601874915967498, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":1,\"levelName\":\"一级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:18:08 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:18:09', '2019-08-08 14:18:09', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967499, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:19:12 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:19:13', '2019-08-08 14:19:13', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967500, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:19:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:19:33', '2019-08-08 14:19:33', '30');
INSERT INTO `sys_operation_log` VALUES (1150601874915967501, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:19:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:19:39', '2019-08-08 14:19:39', '8');
INSERT INTO `sys_operation_log` VALUES (1150601874915967502, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:19:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:19:46', '2019-08-08 14:19:46', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967503, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:20:24 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:20:25', '2019-08-08 14:20:25', '18');
INSERT INTO `sys_operation_log` VALUES (1150601874915967504, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":1,\"levelName\":\"一级\",\"optionAreas\":\"\",\"optionIds\":\"\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:29:48 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:29:49', '2019-08-08 14:29:49', '42');
INSERT INTO `sys_operation_log` VALUES (1150601874915967505, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"\",\"optionIds\":\"\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:30:15 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:30:15', '2019-08-08 14:30:15', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967506, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"\",\"optionIds\":\"\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:35:05 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:35:05', '2019-08-08 14:35:05', '46');
INSERT INTO `sys_operation_log` VALUES (1150601874915967507, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"\",\"optionIds\":\"\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:35:53 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:35:54', '2019-08-08 14:35:54', '16392');
INSERT INTO `sys_operation_log` VALUES (1150601874915967508, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":0,\"areaName\":\"大兴区\",\"level\":1,\"levelName\":\"一级\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:36:56 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:36:56', '2019-08-08 14:36:56', '56');
INSERT INTO `sys_operation_log` VALUES (1150601874915967509, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"areaName\":\"大兴区\",\"level\":2,\"levelName\":\"二级\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:36:56 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:37:02', '2019-08-08 14:37:02', '1');
INSERT INTO `sys_operation_log` VALUES (1150601874915967510, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":28,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"大兴区\",\"optionIds\":\"28\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:36:56 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:37:11', '2019-08-08 14:37:11', '0');
INSERT INTO `sys_operation_log` VALUES (1150601874915967511, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":28,\"parentId\":22,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionIds\":\"21/22\",\"createTime\":\"Aug 8, 2019 2:17:43 PM\",\"updateTime\":\"Aug 8, 2019 2:37:14 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-08 14:37:15', '2019-08-08 14:37:15', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967512, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[28]', '2019-08-08 15:43:39', '2019-08-08 15:43:39', '252');
INSERT INTO `sys_operation_log` VALUES (1150601874915967513, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[22]', '2019-08-08 15:44:46', '2019-08-08 15:44:46', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967514, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-08 17:29:10', '2019-08-08 17:29:10', '165');
INSERT INTO `sys_operation_log` VALUES (1150601874915967515, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-08 17:30:36', '2019-08-08 17:30:36', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967516, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-08 17:39:40', '2019-08-08 17:39:40', '152');
INSERT INTO `sys_operation_log` VALUES (1150601874915967517, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 09:15:33', '2019-08-09 09:15:33', '40');
INSERT INTO `sys_operation_log` VALUES (1150601874915967518, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 09:15:34', '2019-08-09 09:15:34', '24');
INSERT INTO `sys_operation_log` VALUES (1150601874915967519, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:42:54', '2019-08-09 10:42:54', '712');
INSERT INTO `sys_operation_log` VALUES (1150601874915967520, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:44:04', '2019-08-09 10:44:04', '39');
INSERT INTO `sys_operation_log` VALUES (1150601874915967521, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:44:52', '2019-08-09 10:44:52', '59');
INSERT INTO `sys_operation_log` VALUES (1150601874915967522, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:46:11', '2019-08-09 10:46:11', '12');
INSERT INTO `sys_operation_log` VALUES (1150601874915967523, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:47:04', '2019-08-09 10:47:04', '36');
INSERT INTO `sys_operation_log` VALUES (1150601874915967524, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:47:24', '2019-08-09 10:47:24', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967525, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:47:42', '2019-08-09 10:47:42', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967526, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:47:47', '2019-08-09 10:47:47', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967527, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:48:45', '2019-08-09 10:48:45', '11');
INSERT INTO `sys_operation_log` VALUES (1150601874915967528, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:49:18', '2019-08-09 10:49:18', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967529, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:50:38', '2019-08-09 10:50:38', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967530, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:53:06', '2019-08-09 10:53:06', '12910');
INSERT INTO `sys_operation_log` VALUES (1150601874915967531, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:54:13', '2019-08-09 10:54:13', '56');
INSERT INTO `sys_operation_log` VALUES (1150601874915967532, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:56:22', '2019-08-09 10:56:22', '236');
INSERT INTO `sys_operation_log` VALUES (1150601874915967533, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:57:07', '2019-08-09 10:57:07', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967534, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:58:20', '2019-08-09 10:58:20', '113');
INSERT INTO `sys_operation_log` VALUES (1150601874915967535, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 10:59:27', '2019-08-09 10:59:27', '8');
INSERT INTO `sys_operation_log` VALUES (1150601874915967536, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:02:21', '2019-08-09 11:02:21', '254');
INSERT INTO `sys_operation_log` VALUES (1150601874915967537, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:04:07', '2019-08-09 11:04:07', '1773');
INSERT INTO `sys_operation_log` VALUES (1150601874915967538, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:05:26', '2019-08-09 11:05:26', '11');
INSERT INTO `sys_operation_log` VALUES (1150601874915967539, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:05:51', '2019-08-09 11:05:51', '14');
INSERT INTO `sys_operation_log` VALUES (1150601874915967540, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":29,\"parentId\":21,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionIds\":\"21\",\"createTime\":\"Aug 9, 2019 11:06:31 AM\",\"updateTime\":\"Aug 9, 2019 11:06:31 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-09 11:06:31', '2019-08-09 11:06:31', '50');
INSERT INTO `sys_operation_log` VALUES (1150601874915967541, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:06:33', '2019-08-09 11:06:33', '17');
INSERT INTO `sys_operation_log` VALUES (1150601874915967542, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:07:30', '2019-08-09 11:07:30', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967543, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:08:36', '2019-08-09 11:08:36', '26');
INSERT INTO `sys_operation_log` VALUES (1150601874915967544, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:08:59', '2019-08-09 11:08:59', '80');
INSERT INTO `sys_operation_log` VALUES (1150601874915967545, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:09:22', '2019-08-09 11:09:22', '17');
INSERT INTO `sys_operation_log` VALUES (1150601874915967546, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:13:46', '2019-08-09 11:13:46', '136');
INSERT INTO `sys_operation_log` VALUES (1150601874915967547, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:16:24', '2019-08-09 11:16:24', '24');
INSERT INTO `sys_operation_log` VALUES (1150601874915967548, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:16:47', '2019-08-09 11:16:47', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967549, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 11:26:32', '2019-08-09 11:26:32', '95');
INSERT INTO `sys_operation_log` VALUES (1150601874915967550, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:38:10', '2019-08-09 13:38:10', '63');
INSERT INTO `sys_operation_log` VALUES (1150601874915967551, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:40:37', '2019-08-09 13:40:37', '204');
INSERT INTO `sys_operation_log` VALUES (1150601874915967552, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:43:01', '2019-08-09 13:43:01', '128');
INSERT INTO `sys_operation_log` VALUES (1150601874915967553, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:45:22', '2019-08-09 13:45:22', '300');
INSERT INTO `sys_operation_log` VALUES (1150601874915967554, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:45:23', '2019-08-09 13:45:23', '44');
INSERT INTO `sys_operation_log` VALUES (1150601874915967555, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:45:44', '2019-08-09 13:45:44', '26');
INSERT INTO `sys_operation_log` VALUES (1150601874915967556, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:47:13', '2019-08-09 13:47:13', '12');
INSERT INTO `sys_operation_log` VALUES (1150601874915967557, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:48:54', '2019-08-09 13:48:54', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967558, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:53:49', '2019-08-09 13:53:49', '63');
INSERT INTO `sys_operation_log` VALUES (1150601874915967559, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 13:53:50', '2019-08-09 13:53:50', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967560, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 13:56:04', '2019-08-09 13:56:04', '1020');
INSERT INTO `sys_operation_log` VALUES (1150601874915967561, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:22:18', '2019-08-09 14:22:18', '113');
INSERT INTO `sys_operation_log` VALUES (1150601874915967562, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:27:28', '2019-08-09 14:27:28', '1138');
INSERT INTO `sys_operation_log` VALUES (1150601874915967563, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:30:12', '2019-08-09 14:30:12', '72');
INSERT INTO `sys_operation_log` VALUES (1150601874915967564, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:30:50', '2019-08-09 14:30:50', '12');
INSERT INTO `sys_operation_log` VALUES (1150601874915967565, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:31:59', '2019-08-09 14:31:59', '18');
INSERT INTO `sys_operation_log` VALUES (1150601874915967566, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:32:51', '2019-08-09 14:32:51', '16');
INSERT INTO `sys_operation_log` VALUES (1150601874915967567, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:33:57', '2019-08-09 14:33:57', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967568, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:34:08', '2019-08-09 14:34:08', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967569, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:35:41', '2019-08-09 14:35:41', '5');
INSERT INTO `sys_operation_log` VALUES (1150601874915967570, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:37:47', '2019-08-09 14:37:47', '9');
INSERT INTO `sys_operation_log` VALUES (1150601874915967571, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:38:49', '2019-08-09 14:38:49', '9');
INSERT INTO `sys_operation_log` VALUES (1150601874915967572, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:40:41', '2019-08-09 14:40:41', '198');
INSERT INTO `sys_operation_log` VALUES (1150601874915967573, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:43:05', '2019-08-09 14:43:05', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967574, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:44:22', '2019-08-09 14:44:22', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967575, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:45:20', '2019-08-09 14:45:20', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967576, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:48:58', '2019-08-09 14:48:58', '95');
INSERT INTO `sys_operation_log` VALUES (1150601874915967577, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:49:39', '2019-08-09 14:49:39', '98');
INSERT INTO `sys_operation_log` VALUES (1150601874915967578, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:51:45', '2019-08-09 14:51:45', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967579, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:52:09', '2019-08-09 14:52:09', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967580, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:56:04', '2019-08-09 14:56:04', '44');
INSERT INTO `sys_operation_log` VALUES (1150601874915967581, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:56:15', '2019-08-09 14:56:15', '35');
INSERT INTO `sys_operation_log` VALUES (1150601874915967582, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:56:36', '2019-08-09 14:56:36', '9');
INSERT INTO `sys_operation_log` VALUES (1150601874915967583, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:57:21', '2019-08-09 14:57:21', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967584, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:58:05', '2019-08-09 14:58:05', '4');
INSERT INTO `sys_operation_log` VALUES (1150601874915967585, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 14:59:50', '2019-08-09 14:59:50', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967586, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:15:32', '2019-08-09 15:15:32', '154');
INSERT INTO `sys_operation_log` VALUES (1150601874915967587, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:17:09', '2019-08-09 15:17:09', '21');
INSERT INTO `sys_operation_log` VALUES (1150601874915967588, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:18:30', '2019-08-09 15:18:30', '101');
INSERT INTO `sys_operation_log` VALUES (1150601874915967589, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:19:07', '2019-08-09 15:19:07', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967590, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:23:16', '2019-08-09 15:23:16', '105');
INSERT INTO `sys_operation_log` VALUES (1150601874915967591, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:23:23', '2019-08-09 15:23:23', '26');
INSERT INTO `sys_operation_log` VALUES (1150601874915967592, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:25:36', '2019-08-09 15:25:36', '57');
INSERT INTO `sys_operation_log` VALUES (1150601874915967593, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:27:50', '2019-08-09 15:27:50', '116');
INSERT INTO `sys_operation_log` VALUES (1150601874915967594, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:28:06', '2019-08-09 15:28:06', '34');
INSERT INTO `sys_operation_log` VALUES (1150601874915967595, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:29:07', '2019-08-09 15:29:07', '18');
INSERT INTO `sys_operation_log` VALUES (1150601874915967596, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:30:37', '2019-08-09 15:30:37', '12');
INSERT INTO `sys_operation_log` VALUES (1150601874915967597, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:30:49', '2019-08-09 15:30:49', '50');
INSERT INTO `sys_operation_log` VALUES (1150601874915967598, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:32:56', '2019-08-09 15:32:56', '53');
INSERT INTO `sys_operation_log` VALUES (1150601874915967599, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:32:56', '2019-08-09 15:32:56', '21');
INSERT INTO `sys_operation_log` VALUES (1150601874915967600, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:34:51', '2019-08-09 15:34:51', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967601, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:43:13', '2019-08-09 15:43:13', '55');
INSERT INTO `sys_operation_log` VALUES (1150601874915967602, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:49:44', '2019-08-09 15:49:44', '178');
INSERT INTO `sys_operation_log` VALUES (1150601874915967603, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 15:49:44', '2019-08-09 15:49:44', '5');
INSERT INTO `sys_operation_log` VALUES (1150601874915967604, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 15:49:47', '2019-08-09 15:49:47', '1053');
INSERT INTO `sys_operation_log` VALUES (1150601874915967605, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":30,\"parentId\":29,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 9, 2019 4:03:50 PM\",\"updateTime\":\"Aug 9, 2019 4:03:50 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-09 16:03:50', '2019-08-09 16:03:50', '62');
INSERT INTO `sys_operation_log` VALUES (1150601874915967606, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":30,\"parentId\":24,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"美国\",\"optionIds\":\"\",\"createTime\":\"Aug 9, 2019 4:03:50 PM\",\"updateTime\":\"Aug 9, 2019 4:03:50 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-09 16:04:16', '2019-08-09 16:04:16', '5');
INSERT INTO `sys_operation_log` VALUES (1150601874915967607, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 16:13:57', '2019-08-09 16:13:57', '55');
INSERT INTO `sys_operation_log` VALUES (1150601874915967608, '操作日志', '角色分页', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'pageList', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-09 16:13:59', '2019-08-09 16:13:59', '20');
INSERT INTO `sys_operation_log` VALUES (1150601874915967609, '操作日志', '用户所属角色', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'userRole', '成功', '', '2019-08-09 16:14:32', '2019-08-09 16:14:32', '22');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', '2018-10-10 22:39:38', '2018-12-23 11:45:49');
INSERT INTO `sys_role` VALUES (2, '游客', '游客', '2018-12-23 03:45:15', '2019-04-12 07:12:41');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1633 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1437, 2, 1);
INSERT INTO `sys_role_menu` VALUES (1438, 2, 2);
INSERT INTO `sys_role_menu` VALUES (1439, 2, 3);
INSERT INTO `sys_role_menu` VALUES (1440, 2, 12);
INSERT INTO `sys_role_menu` VALUES (1441, 2, 16);
INSERT INTO `sys_role_menu` VALUES (1442, 2, 14);
INSERT INTO `sys_role_menu` VALUES (1443, 2, 15);
INSERT INTO `sys_role_menu` VALUES (1444, 2, 17);
INSERT INTO `sys_role_menu` VALUES (1445, 2, 4);
INSERT INTO `sys_role_menu` VALUES (1446, 2, 18);
INSERT INTO `sys_role_menu` VALUES (1447, 2, 21);
INSERT INTO `sys_role_menu` VALUES (1448, 2, 20);
INSERT INTO `sys_role_menu` VALUES (1449, 2, 5);
INSERT INTO `sys_role_menu` VALUES (1450, 2, 22);
INSERT INTO `sys_role_menu` VALUES (1451, 2, 24);
INSERT INTO `sys_role_menu` VALUES (1452, 2, 6);
INSERT INTO `sys_role_menu` VALUES (1453, 2, 26);
INSERT INTO `sys_role_menu` VALUES (1454, 2, 25);
INSERT INTO `sys_role_menu` VALUES (1455, 2, 40);
INSERT INTO `sys_role_menu` VALUES (1456, 2, 41);
INSERT INTO `sys_role_menu` VALUES (1457, 2, 45);
INSERT INTO `sys_role_menu` VALUES (1458, 2, 46);
INSERT INTO `sys_role_menu` VALUES (1459, 2, 42);
INSERT INTO `sys_role_menu` VALUES (1460, 2, 47);
INSERT INTO `sys_role_menu` VALUES (1461, 2, 48);
INSERT INTO `sys_role_menu` VALUES (1462, 2, 49);
INSERT INTO `sys_role_menu` VALUES (1463, 2, 43);
INSERT INTO `sys_role_menu` VALUES (1464, 2, 44);
INSERT INTO `sys_role_menu` VALUES (1465, 2, 50);
INSERT INTO `sys_role_menu` VALUES (1466, 2, 51);
INSERT INTO `sys_role_menu` VALUES (1467, 2, 52);
INSERT INTO `sys_role_menu` VALUES (1576, 1, 62);
INSERT INTO `sys_role_menu` VALUES (1577, 1, 1);
INSERT INTO `sys_role_menu` VALUES (1578, 1, 2);
INSERT INTO `sys_role_menu` VALUES (1579, 1, 3);
INSERT INTO `sys_role_menu` VALUES (1580, 1, 12);
INSERT INTO `sys_role_menu` VALUES (1581, 1, 16);
INSERT INTO `sys_role_menu` VALUES (1582, 1, 13);
INSERT INTO `sys_role_menu` VALUES (1583, 1, 14);
INSERT INTO `sys_role_menu` VALUES (1584, 1, 15);
INSERT INTO `sys_role_menu` VALUES (1585, 1, 17);
INSERT INTO `sys_role_menu` VALUES (1586, 1, 4);
INSERT INTO `sys_role_menu` VALUES (1587, 1, 18);
INSERT INTO `sys_role_menu` VALUES (1588, 1, 21);
INSERT INTO `sys_role_menu` VALUES (1589, 1, 19);
INSERT INTO `sys_role_menu` VALUES (1590, 1, 20);
INSERT INTO `sys_role_menu` VALUES (1591, 1, 5);
INSERT INTO `sys_role_menu` VALUES (1592, 1, 22);
INSERT INTO `sys_role_menu` VALUES (1593, 1, 23);
INSERT INTO `sys_role_menu` VALUES (1594, 1, 24);
INSERT INTO `sys_role_menu` VALUES (1595, 1, 6);
INSERT INTO `sys_role_menu` VALUES (1596, 1, 26);
INSERT INTO `sys_role_menu` VALUES (1597, 1, 27);
INSERT INTO `sys_role_menu` VALUES (1598, 1, 25);
INSERT INTO `sys_role_menu` VALUES (1599, 1, 7);
INSERT INTO `sys_role_menu` VALUES (1600, 1, 29);
INSERT INTO `sys_role_menu` VALUES (1601, 1, 30);
INSERT INTO `sys_role_menu` VALUES (1602, 1, 28);
INSERT INTO `sys_role_menu` VALUES (1603, 1, 31);
INSERT INTO `sys_role_menu` VALUES (1604, 1, 32);
INSERT INTO `sys_role_menu` VALUES (1605, 1, 33);
INSERT INTO `sys_role_menu` VALUES (1606, 1, 10);
INSERT INTO `sys_role_menu` VALUES (1607, 1, 34);
INSERT INTO `sys_role_menu` VALUES (1608, 1, 11);
INSERT INTO `sys_role_menu` VALUES (1609, 1, 35);
INSERT INTO `sys_role_menu` VALUES (1610, 1, 8);
INSERT INTO `sys_role_menu` VALUES (1611, 1, 37);
INSERT INTO `sys_role_menu` VALUES (1612, 1, 38);
INSERT INTO `sys_role_menu` VALUES (1613, 1, 39);
INSERT INTO `sys_role_menu` VALUES (1614, 1, 36);
INSERT INTO `sys_role_menu` VALUES (1615, 1, 40);
INSERT INTO `sys_role_menu` VALUES (1616, 1, 41);
INSERT INTO `sys_role_menu` VALUES (1617, 1, 45);
INSERT INTO `sys_role_menu` VALUES (1618, 1, 46);
INSERT INTO `sys_role_menu` VALUES (1619, 1, 42);
INSERT INTO `sys_role_menu` VALUES (1620, 1, 47);
INSERT INTO `sys_role_menu` VALUES (1621, 1, 48);
INSERT INTO `sys_role_menu` VALUES (1622, 1, 49);
INSERT INTO `sys_role_menu` VALUES (1623, 1, 43);
INSERT INTO `sys_role_menu` VALUES (1624, 1, 44);
INSERT INTO `sys_role_menu` VALUES (1625, 1, 50);
INSERT INTO `sys_role_menu` VALUES (1626, 1, 51);
INSERT INTO `sys_role_menu` VALUES (1627, 1, 52);
INSERT INTO `sys_role_menu` VALUES (1628, 1, 57);
INSERT INTO `sys_role_menu` VALUES (1629, 1, 58);
INSERT INTO `sys_role_menu` VALUES (1630, 1, 59);
INSERT INTO `sys_role_menu` VALUES (1631, 1, 60);
INSERT INTO `sys_role_menu` VALUES (1632, 1, 61);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `avatar` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `account` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名字',
  `dept_id` bigint(20) NULL DEFAULT NULL,
  `birthday` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生日',
  `sex` int(2) NULL DEFAULT NULL COMMENT '性别（1：男 2：女）',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态(1：可用  0：不可用)',
  `version` int(20) NULL DEFAULT NULL COMMENT '保留字段',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` tinyint(1) NULL DEFAULT NULL,
  `company_id` bigint(20) NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/50099e79-d9b6-4eaf-82fe-f912dad845ba.jpg', 'admin', 'aa0d7f0f4fc75910c2cab9a3547d4ec5fdfea6095c27fd2d13e17dc216df3581', 'BFDze8hBJwwhOw3BDvhg', 'admin', NULL, '2018-10-08', 1, 'admin@qq.com', '13412341234', 1, NULL, NULL, NULL, '2018-10-31 17:48:40', '2019-07-26 17:40:05', 0, NULL);
INSERT INTO `sys_user` VALUES (2, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/50099e79-d9b6-4eaf-82fe-f912dad845ba.jpg', 'test', '7848e5f0b4a6d48ad145984735bf98efe2ff2ab4f99a92b2c29201207ea3fe5f', 'ZCCRZ4gOfa8WzorCBFii', 'test', 4, '2019-07-18', 1, 'test@163.com', '13412341234', 1, NULL, NULL, NULL, '2018-12-11 09:55:35', '2019-07-16 10:36:25', 0, 1);
INSERT INTO `sys_user` VALUES (3, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/511f81d4-f216-484a-835b-743c4648a080.jpg', 'qwe', '8a3f7dd608fac8f941c1bafc8202b0e918b7193d5350871a58baa3b4f3e46658', 'B0nbSiCZSvHPSvyLk6Sj', 'qwe', 9, '2019-07-26', 1, 'Q@Q163.com', '13412341234', 1, NULL, NULL, NULL, '2019-07-16 14:55:50', '2019-08-05 16:25:40', 0, 7);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (63, 2, 2);
INSERT INTO `sys_user_role` VALUES (64, 1, 1);
INSERT INTO `sys_user_role` VALUES (75, 3, 2);

-- ----------------------------
-- Table structure for user_area
-- ----------------------------
DROP TABLE IF EXISTS `user_area`;
CREATE TABLE `user_area`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '父ID',
  `area_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区域名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '级别',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '级别名称',
  `option_areas` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联区域',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_area
-- ----------------------------
INSERT INTO `user_area` VALUES (21, 0, '全国', 1, '2019-08-08 10:49:06', '2019-08-08 10:49:06', '一级', NULL);
INSERT INTO `user_area` VALUES (24, 0, '美国', 1, '2019-08-08 10:53:37', '2019-08-08 10:53:37', '一级', NULL);
INSERT INTO `user_area` VALUES (29, 21, '北京', 2, '2019-08-09 11:06:31', '2019-08-09 11:06:31', '二级', '全国');
INSERT INTO `user_area` VALUES (30, 29, '大兴区', 3, '2019-08-09 16:03:50', '2019-08-09 16:03:50', '三级', '全国/北京');

-- ----------------------------
-- Table structure for user_config
-- ----------------------------
DROP TABLE IF EXISTS `user_config`;
CREATE TABLE `user_config`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `config_id` int(6) NULL DEFAULT NULL COMMENT '配置ID',
  `param_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `param_value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int(4) NULL DEFAULT NULL COMMENT '状态（1：启动，2：停用）',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_config
-- ----------------------------
INSERT INTO `user_config` VALUES (1, 1004, '1', '一级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (2, 1004, '2', '二级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (3, 1004, '3', '三级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (4, 1004, '4', '四级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (5, 1004, '5', '五级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (6, 1004, '6', '六级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (7, 1004, '7', '七级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (8, 1004, '8', '八级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (9, 1004, '9', '九级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (10, 1004, '10', '十级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');

-- ----------------------------
-- Table structure for user_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE `user_detail`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `job_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工号',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号',
  `area_id` bigint(32) NULL DEFAULT NULL COMMENT '区域ID',
  `role_id` bigint(32) NULL DEFAULT NULL COMMENT '角色ID',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态（1：正常，0：锁定）',
  `bound_time` datetime(0) NULL DEFAULT NULL COMMENT '绑定时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_detail
-- ----------------------------
INSERT INTO `user_detail` VALUES (1, '20190805', 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/50099e79-d9b6-4eaf-82fe-f912dad845ba.jpg', '墨子', '王林', '18212341234', 29, 2, 1, '2019-08-05 15:02:45', '2019-08-05 15:02:49', '2019-08-09 17:07:31');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '级别',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '级别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, '管理者', 1, '2019-08-05 14:58:58', '2019-08-05 14:59:02', '一级');
INSERT INTO `user_role` VALUES (2, '大区经理', 2, '2019-08-05 14:59:25', '2019-08-05 14:59:27', '二级');

SET FOREIGN_KEY_CHECKS = 1;
