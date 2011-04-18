package utils;

import fj.F;
import java.util.Map;
import java.util.Hashtable;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Utilities{
	public static void processArgs(String[] regexes, String[] args,
								   F<Map<String,String>, Void> f){
		class ParseArgs{
			Map<String,String> parseArgs(String[] regexes, String[] args){
				Map<String,String> optionsAndValues = new Hashtable<String,String>();
				for (String s: args) {
					for (String regex: regexes) {
						//Pattern p = Pattern.compile(regex);
						//Matcher m = p.matcher(s);
						if (Pattern.matches(regex,s)) {
							String[] optionAndValue = s.split(":", 2);
							optionsAndValues.put(optionAndValue[0], optionAndValue[1]);
						}

						//if (matcher.find()) {

						//}
					}
				}
				return optionsAndValues;
			}
		}
		Map<String,String> argsAndValues = (new ParseArgs()).parseArgs(regexes, args);
		f.f(argsAndValues);
	}
}

