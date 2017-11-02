package com.nwx.bean;

import java.util.HashMap;
import java.util.Map;
import java.util.Observable;

/**
 * Created by losil_000 on 2017/10/28.
 * 通用的返回类
 */
public class Msg {
//    状态码
    private int code;
    //提示数据
    private String msg;
    //用户要返回的用户数据
    private Map<String,Object> returnMsg=new HashMap<String, Object>();
    public static Msg success(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg fail(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String  key,Object value){
        this.getReturnMsg().put(key,value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getReturnMsg() {
        return returnMsg;
    }

    public void setReturnMsg(Map<String, Object> returnMsg) {
        this.returnMsg = returnMsg;
    }
}
