package com.ksh.beam.common.sign;

import com.ksh.beam.common.sign.security.impl.Base64SecurityAction;
import com.ksh.beam.common.utils.MD5Util;

public class SignTest {

    public static void main(String[] args) {
        Base64SecurityAction base64SecurityAction = new Base64SecurityAction();

        String a = "{\n" +
                "  \"hospitalId\": 0,\n" +
                "  \"meetingTime\": \"2019-10-17 06:12:33\",\n" +
                "  \"meetingType\": 1,\n" +
                "  \"prePersons\": 100,\n" +
                "  \"speakersId\": 0,\n" +
                "  \"topic\": \"新的\"\n" +
                "}";

//                {
//                    "object":"ewogICJob3NwaXRhbElkIjogMCwKICAibWVldGluZ1RpbWUiOiAiMjAxOS0xMC0xNyAwNjoxMjozMyIsCiAgIm1lZXRpbmdUeXBlIjogMSwKICAicHJlUGVyc29ucyI6IDEwMCwKICAic3BlYWtlcnNJZCI6IDAsCiAgInRvcGljIjogIuaWsOeahCIKfQ==",
//                    "sign":"3f9197e091cbb2d52abdeaa3b987560c"
//                }
        String o = base64SecurityAction.doAction(a);
        System.out.println(o);
        String encrypt =  MD5Util.encrypt(o + "miyao");
        System.out.println(encrypt);
        String u = base64SecurityAction.unlock(o);
        System.out.println(u);
    }
}
