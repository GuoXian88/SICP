class StringDemo
{
    public static void main(String[] args)
    {
        System.out.println('Hello World!');
        String s = "a";
        System.out.println(s.length());

        s = "ab";
        System.out.println((int)s.charAt(0));
        System.out.println(s.length());

        s = "";
        System.out.println(s.length());
        System.out.println(s.length() == 0);
        System.out.println(s == null);
        
        s = null;
        System.out.println(s == null);
        //System.out.println(s.length());
        //int i = null;
        
        // concatenation
        System.out.println("a" + "b");
        System.out.println("a" +  1 );
        System.out.println("a" +  1 + "2");
        System.out.println("a" +  1 +  2 );
        System.out.println( 1  +  2 + "a");
        
        s = "abc";
        System.out.println(s.concat("def"));
        System.out.println(s + "def");
        
        s = "hello world";
        System.out.println(s.contains("lo"));
        
        // comparisons
        System.out.println("word".compareTo("work"));
        System.out.println("word".compareTo("words"));
        System.out.println("word".compareTo("wor"));
        System.out.println("word".equals("work"));
        
        // equality
        String ab = "ab";
        String cd = "cd";
        String s1 = "abcd";
        String s2 = ab + cd;
        String s3 = "ab" + "cd";
        String s4 = "ab".concat("cd");
        // Note that s1, s2, s3, and s4 all hold the characters "abcd"
        System.out.println("See how equals works as expected for ALL of them:");
        System.out.println(s1.equals(s2));
        System.out.println(s1.equals(s3));
        System.out.println(s1.equals(s4));
        System.out.println("But == only works as expected for SOME of them:");
        System.out.println(s1 == s2);
        System.out.println(s1 == s3);
        System.out.println(s1 == s4);
        // Moral of the story: Do NOT use "==" with Strings -- the results are unpredictable!
    
        // a pattern using concat to build a result string
        // CAUTION - do NOT use if you're constructing a LOT of Strings!
        // Once we start using Objects, I will show you a better way...
        String result = "";
        for (int i = 0; i < 10; i++)
        {
            result += "Mark";
        }
        System.out.println(result);
        System.out.println("first character is " + result.charAt(1));
        System.out.println("last character is ");
        System.out.println(result.contains("ark"));
    }
 }
