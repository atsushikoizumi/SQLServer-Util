 S E L E C T    
 	 ' d i s t r i b u t i o n _ a g e n t '   A S   a g e n t _ t y p e ,  
 	 d a . p u b l i c a t i o n ,  
 	 a p . p r o f i l e _ n a m e ,  
 	 C A S E   d a . s u b s c r i p t i o n _ t y p e  
 	 	 W H E N   0   T H E N   ' P u s h '  
 	 	 W H E N   1   T H E N   ' P u l l '  
 	 	 W H E N   2   T H E N   ' A n o n y m o u s '  
 	 	 E L S E   C A S T ( d a . s u b s c r i p t i o n _ t y p e   A S   s y s n a m e )  
 	 E N D   A S   s u b s c r i p t i o n _ t y p e ,  
 	 d a . n a m e   A S   s q l s e r v e r _ a g e n t _ j o b _ n a m e ,  
 	 d a . l o c a l _ j o b ,  
 	 a . a r t i c l e ,  
 	 s r _ p . m s r s _ s r v n a m e   A S   p u b l i s h e r _ s e r v e r ,  
 	 d a . p u b l i s h e r _ d b ,  
 	 a . s o u r c e _ o w n e r   +   ' . '   +   a . s o u r c e _ o b j e c t   A S   s o u r c e _ o b j e c t ,  
 	 s r _ s . m s r s _ s r v n a m e   A S   s u b s c l i b e r _ s e r v e r ,  
 	 d a . s u b s c r i b e r _ d b ,  
 	 C A S E  
 	 	 W H E N   a . d e s t i n a t i o n _ o w n e r   I S   N U L L   T H E N     a . d e s t i n a t i o n _ o b j e c t    
 	 	 E L S E   d e s t i n a t i o n _ o w n e r   +   ' . '   +   d e s t i n a t i o n _ o b j e c t  
 	 E N D   A S   d e s t i n a t i o n _ o b j e c t  
 F R O M    
 	 d i s t r i b u t i o n . d b o . M S d i s t r i b u t i o n _ a g e n t s   A S   d a   W I T H ( N O L O C K )  
 	 L E F T   J O I N  
 	 	 m s d b . d b o . M S a g e n t _ p r o f i l e s   A S   a p   W I T H ( N O L O C K )  
 	 O N  
 	 	 a p . a g e n t _ t y p e   =   3   - -   1 : s n a p s h o t _ a g e n t   /   2 : l o g r e a d e r _ a g e n t   /   3 : d i s t r i b u t i o n _ a g e n t   /   4 : m e r g e _ a g e n t   /   9 : q u e u e _ r e a d e r _ a g e n t  
 	 	 A N D  
 	 	 a p . p r o f i l e _ i d   =   d a . p r o f i l e _ i d  
 	 L E F T   J O I N  
 	 	 d i s t r i b u t i o n . d b o . M S s u b s c r i p t i o n s   A S   s   W I T H ( N O L O C K )  
 	 O N  
 	 	 s . p u b l i s h e r _ i d   =   d a . p u b l i s h e r _ i d  
 	 	 A N D  
 	 	 s . p u b l i s h e r _ d a t a b a s e _ i d   =   d a . p u b l i s h e r _ d a t a b a s e _ i d  
 	 	 A N D  
 	 	 s . p u b l i s h e r _ d b   =   d a . p u b l i s h e r _ d b  
 	 	 A N D  
 	 	 s . s u b s c r i b e r _ d b   =   d a . s u b s c r i b e r _ d b  
 	 	 A N D  
 	 	 s . s u b s c r i b e r _ i d   =   d a . s u b s c r i b e r _ i d  
 	 	 A N D  
 	 	 s . s u b s c r i b e r _ i d   >   0  
 	 L E F T   J O I N  
 	 	 d i s t r i b u t i o n . d b o . M S a r t i c l e s   A S   a   W I T H ( N O L O C K )  
 	 O N  
 	 	 a . a r t i c l e _ i d   =   s . a r t i c l e _ i d  
 	 	 A N D  
 	 	 a . p u b l i s h e r _ d b   =   s . p u b l i s h e r _ d b  
 	 L E F T   J O I N   d i s t r i b u t i o n . d b o . M S s y s s e r v e r s _ r e p l s e r v e r s   A S   s r _ p   W I T H ( N O L O C K )  
 	 O N  
 	 	 s r _ p . m s r s _ s r v i d   =   s . p u b l i s h e r _ i d  
 	 L E F T   J O I N   d i s t r i b u t i o n . d b o . M S s y s s e r v e r s _ r e p l s e r v e r s   A S   s r _ s   W I T H ( N O L O C K )  
 	 O N  
 	 	 s r _ s . m s r s _ s r v i d   =   s . s u b s c r i b e r _ i d  
 W H E R E    
 	 d a . s u b s c r i b e r _ i d   >   0  
 O R D E R   B Y  
 	 d a . p u b l i c a t i o n   A S C ,  
 	 a . a r t i c l e   A S C ,  
 	 s . s u b s c r i b e r _ d b   A S C ,  
 	 s r _ s . m s r s _ s r v n a m e   A S C  
 O P T I O N ( R E C O M P I L E ,   M A X D O P   1 )  
  
 S E L E C T    
 	 ' l o g r e a d e r _ a g e n t '   A S   a g e n t _ t y p e ,  
 	 l a . p u b l i c a t i o n ,  
 	 a p . p r o f i l e _ n a m e ,  
 	 l a . n a m e   A S   s q l s e r v e r _ a g e n t _ j o b _ n a m e ,  
 	 l a . l o c a l _ j o b ,  
 	 s r _ p . m s r s _ s r v n a m e ,  
 	 l a . p u b l i s h e r _ d b  
 F R O M    
 	 d i s t r i b u t i o n . d b o . M S l o g r e a d e r _ a g e n t s   A S   l a   W I T H ( N O L O C K )  
 	 L E F T   J O I N  
 	 	 m s d b . d b o . M S a g e n t _ p r o f i l e s   A S   a p   W I T H ( N O L O C K )  
 	 O N  
 	 	 a p . a g e n t _ t y p e   =   2   - -   1 : s n a p s h o t _ a g e n t   /   2 : l o g r e a d e r _ a g e n t   /   3 : d i s t r i b u t i o n _ a g e n t   /   4 : m e r g e _ a g e n t   /   9 : q u e u e _ r e a d e r _ a g e n t  
 	 	 A N D  
 	 	 a p . p r o f i l e _ i d   =   l a . p r o f i l e _ i d  
 	 L E F T   J O I N   d i s t r i b u t i o n . d b o . M S s y s s e r v e r s _ r e p l s e r v e r s   A S   s r _ p   W I T H ( N O L O C K )  
 	 	 O N   s r _ p . m s r s _ s r v i d   =   l a . p u b l i s h e r _ i d  
 O P T I O N ( R E C O M P I L E ,   M A X D O P   1 )  
  
 S E L E C T    
 	 ' s n a p s h o t _ a g e n t '   A S   a g e n t _ t y p e ,  
 	 s a . p u b l i c a t i o n ,  
 	 a p . p r o f i l e _ n a m e ,  
 	 s a . n a m e   A S   s q l s e r v e r _ a g e n t _ j o b _ n a m e ,  
 	 s a . l o c a l _ j o b ,  
 	 a . a r t i c l e ,  
 	 s r _ p . m s r s _ s r v n a m e   A S   p u b l i s h e r _ s e r v e r ,  
 	 s a . p u b l i s h e r _ d b ,  
 	 a . s o u r c e _ o w n e r   +   ' . '   +   a . s o u r c e _ o b j e c t   A S   s o u r c e _ o b j e c t ,  
 	 s r _ s . m s r s _ s r v n a m e   A S   s u b s c l i b e r _ s e r v e r ,  
 	 s . s u b s c r i b e r _ d b ,  
 	 C A S E  
 	 	 W H E N   a . d e s t i n a t i o n _ o w n e r   I S   N U L L   T H E N     a . d e s t i n a t i o n _ o b j e c t    
 	 	 E L S E   d e s t i n a t i o n _ o w n e r   +   ' . '   +   d e s t i n a t i o n _ o b j e c t  
 	 E N D   A S   d e s t i n a t i o n _ o b j e c t  
 F R O M    
 	 d i s t r i b u t i o n . d b o . M S s n a p s h o t _ a g e n t s   A S   s a   W I T H ( N O L O C K )  
 	 L E F T   J O I N  
 	 	 m s d b . d b o . M S a g e n t _ p r o f i l e s   A S   a p   W I T H ( N O L O C K )  
 	 O N  
 	 	 a p . a g e n t _ t y p e   =   1   - -   1 : s n a p s h o t _ a g e n t   /   2 : l o g r e a d e r _ a g e n t   /   3 : d i s t r i b u t i o n _ a g e n t   /   4 : m e r g e _ a g e n t   /   9 : q u e u e _ r e a d e r _ a g e n t  
 	 	 A N D  
 	 	 a p . p r o f i l e _ i d   =   s a . p r o f i l e _ i d  
 	 L E F T   J O I N  
 	 	 d i s t r i b u t i o n . d b o . M S s u b s c r i p t i o n s   A S   s   W I T H ( N O L O C K )  
 	 O N  
 	 	 s . p u b l i s h e r _ i d   =   s a . p u b l i s h e r _ i d  
 	 	 A N D  
 	 	 s . p u b l i s h e r _ d b   =   s a . p u b l i s h e r _ d b  
 	 	 A N D  
 	 	 s . p u b l i c a t i o n _ i d   =   s a . i d  
 	 	 A N D  
 	 	 s . s u b s c r i b e r _ i d   >   0  
 	 L E F T   J O I N  
 	 	 d i s t r i b u t i o n . d b o . M S a r t i c l e s   A S   a   W I T H ( N O L O C K )  
 	 O N  
 	 	 a . a r t i c l e _ i d   =   s . a r t i c l e _ i d  
 	 	 A N D  
 	 	 a . p u b l i s h e r _ d b   =   s . p u b l i s h e r _ d b  
 	 L E F T   J O I N   d i s t r i b u t i o n . d b o . M S s y s s e r v e r s _ r e p l s e r v e r s   A S   s r _ p   W I T H ( N O L O C K )  
 	 O N  
 	 	 s r _ p . m s r s _ s r v i d   =   s . p u b l i s h e r _ i d  
 	 L E F T   J O I N   d i s t r i b u t i o n . d b o . M S s y s s e r v e r s _ r e p l s e r v e r s   A S   s r _ s   W I T H ( N O L O C K )  
 	 O N  
 	 	 s r _ s . m s r s _ s r v i d   =   s . s u b s c r i b e r _ i d  
 O R D E R   B Y  
 	 s a . p u b l i c a t i o n   A S C ,  
 	 a . a r t i c l e   A S C ,  
 	 s . s u b s c r i b e r _ d b   A S C ,  
 	 s r _ s . m s r s _ s r v n a m e   A S C  
 O P T I O N ( R E C O M P I L E ,   M A X D O P   1 )  
