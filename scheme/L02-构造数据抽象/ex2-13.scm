;self solution


;answer
No scheme, just math. If Ca is center of a, and Ta is tolerance of a, a is the interval

  a = [Ca*(1 - 0.5*Ta), Ca*(1 + 0.5*Ta)]
and b is

  b = [Cb*(1 - 0.5*Tb), Cb*(1 + 0.5*Tb)]
If the endpoints are positive, a*b has the endpoints (after simplifying):

  a*b = [Ca*Cb*(1 - 0.5*(Ta + Tb) + 0.25*Ta*Tb),
         Ca*Cb*(1 + 0.5*(Ta + Tb) + 0.25*Ta*Tb)]