   import 'dart:html';

   class CookieManager {

      static addToCookie(String key, dynamic value) {
        // 2592000 sec = 30 days.
        document.cookie = "$key=$value; max-age=2592000; path=/;";
      }

      static updateUserCookie({required bool isLogin, String? email, String? password}){
        if(isLogin){
          document.cookie = "login=true; max-age=15920000; path=/;";
          document.cookie = "email=$email; max-age=1592000; path=/;";
          document.cookie = "password=$password; max-age=1592000; path=/;";
        }else{
          document.cookie = "login=false; max-age=15920000; path=/;";
          document.cookie = "email=''; max-age=1592000; path=/;";
          document.cookie = "password=''; max-age=1592000; path=/;";
        }
      }

      static Map? getCookieAsMap() {
        String? cookies = document.cookie!;
        List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : [];
        Map finalMap = {}; 
        for (int i = 0; i < listValues.length; i++) {
          Map listToMap = {listValues[i].split("=").elementAt(0).replaceAll(' ', '') : listValues[i].split("=").elementAt(1).replaceAll(' ', '')};
          finalMap.addEntries(listToMap.entries);
        }
        return finalMap;
      }

      static dynamic getCookie(String key) {
        String? cookies = document.cookie!;
        List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : [];
        Map finalMap = {}; 
        for (int i = 0; i < listValues.length; i++) {
          Map listToMap = {listValues[i].split("=").elementAt(0).replaceAll(' ', '') : listValues[i].split("=").elementAt(1).replaceAll(' ', '')};
          finalMap.addEntries(listToMap.entries);
        }
        return finalMap[key];
      }
    }