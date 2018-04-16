public class TypeDemo
{
    public static boolean almostEqual(double d1, double d2)
    {
        double epsilon = 0.000001;
        return Math.abs(d1-d2) < epsilon;
    }
    
    public static void main(String[] args)
    {
        System.out.println(Integer.MAX_VALUE);
        System.out.println(Integer.MIN_VALUE);
        System.out.println(Double.MAX_VALUE);
        System.out.println((int)Character.MAX_VALUE);
        
        double d1 = 29.0;
        double d2 = (29 / 7.0) * 7.0;
        System.out.println(29/7);
        System.out.println(d1);
        System.out.println(d1 == d2);
        System.out.println(d2);
        
        double epsilon = 0.00000001;
        System.out.println(almostEqual(d1,d2));
        
        char c = 'e';
        System.out.println(c);
        System.out.println((int)c);  // equivalent of Python ord()
        System.out.println((char)(c - ('a'-'A')));  // char's can be operated on as ints
        
        char a = 65;
        System.out.println(a);
        char n = '2';
        System.out.println(n + '2');
    }
}