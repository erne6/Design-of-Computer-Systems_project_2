; Autor reseni: 

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xname"  ; sem doplnte vas login 

cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text

        ; ZDE NAHRADTE KOD VASIM RESENIM <=
main:
                
                daddi r26, r0, 0     

while:
                        lb r8, login(r26)  
                        slti r5, r8, 97    
                        bne r5, r0, while_stop  

                        daddi r5, r0, 1    
                        and r5, r26, r5     
                        beq r5, r0, add   
                        b sub      


sub:
                        daddi r8, r8, -22 
                        b stop_if            


add:
                        daddi r8, r8, 3 
                        b stop_if


stop_if:

                        slti r5, r8, 97    
                        bne r5, r0, ness_to_add   
                        slti r5, r8, 123   
                        bne r5, r0, ness_to_stop   
                        b ness_to_sub          


ness_to_add:
                        daddi r8, r8, 26  
                        b ness_to_stop         


ness_to_sub:
                        daddi r8, r8, -26 
                        b ness_to_stop          


ness_to_stop:
                        sb r8, cipher(r26) 

                        daddi r26, r26, 1   
                        b while	            


while_stop:
                        daddi r4, r0, cipher 
                        al print_string    

                        yscall 0    


print_string:   ; adresa retezce se ocekava v r4
        sw      r4, params_sys5(r0)
        daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
        syscall 5   ; systemova procedura - vypis retezce na terminal
        jr      r31 ; return - r31 je urcen na return address