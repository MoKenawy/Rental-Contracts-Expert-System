(defrule General-query
    =>
    (printout t "Hello , What can i help you with? (Property/Others)" crlf)
    (bind  ?q-type (read))
    (assert(query-type ?q-type))
)

(defrule Property-query
    (query-type Property)
    =>
    (printout t "What area are you facing a problem in" crlf)
    (printout t "1. Lease-contracts." crlf)
    (printout t "2. Other." crlf)
    
    (printout t "Choice : " )
    (bind ?property-q (read))
    (printout t "" crlf)


    (if (= ?property-q 1)
        then
        (assert(property-query lease-contracts))
        else
        (assert(property-query other))
    )
)

(defrule Lease-query
    (property-query lease-contracts)
    =>
    (printout t "What area are you facing a problem in" crlf)
    (printout t "1. Rent issues." crlf)
    (printout t "2. Duration issues." crlf)

    (printout t "Choice : " )
    (bind ?issue (read))
    (printout t "" crlf)

    (if (= ?issue 1)
        then
        (assert(issue rent))
        else
        (assert(issue duration))
    )
)




;Lease-Duration-Rules
(defrule duration-query
    (issue duration)
    =>
    (printout t "Is the duration period specified?" crlf)

    (printout t "1. Yes." crlf)
    (printout t "2. No." crlf)

    (printout t "Choice : " )
    (bind ?duration-specified (read))
    (printout t "" crlf)

    (if (= ?duration-specified 1)
        then
            (assert(duration-state specified))
        else
            (assert(duration-state unspecified))
    )
)



(defrule duration-specified-rule
    (duration-state specified)
    =>
    (printout t "Is the duration period specified more than 3 years?" crlf)
    (printout t "1. Yes." crlf)
    (printout t "2. No." crlf)

    (printout t "Choice : " )
    (bind ?choice (read))
    (printout t "" crlf)

    (if (= ?choice 1)
        then
        (assert(lease-duration  permission-required))
        else
        (assert(lease-duration  legit))
    )
)

(defrule legit-duration-rule
    (lease-duration  legit)
    =>
    (printout t "Don't worry, There's no problem in contract." crlf)
    (assert(exit-chat))

)

(defrule permission-rule
    (lease-duration  permission-required)
    =>
    (printout t "Do you have only administration rights?" crlf)
    (printout t "1. Yes." crlf)
    (printout t "2. No." crlf)

    (printout t "Choice : " )
    (bind ?choice (read))
    (printout t "" crlf)

    (if (= ?choice 1)
        then
        (assert(permission unavailable))
        else
        (assert(permission available))
    )
)


(defrule duration-permission-available
    (lease-duration  permission-required)
    (permission available)
    =>
    (printout t "Don't worry, There's no problem in contract." crlf)
    (assert(exit-chat))

)

(defrule duration-permission-unavailable
    (lease-duration  permission-required)
    (permission unavailable)
    =>
    (printout t "Article 559 : Duration is considered to be 3 Years, as long as there's no writing that says otherwise. " crlf)
    (assert(exit-chat))

)


(defrule duration-unspecified-rule
    (duration-state unspecified)
    =>
    (printout t "Article 563: If the lease is concluded without agreement on a duration or for an indefinite duration, the lease shall be considered concluded for the specified period for rent payment." crlf)
    (assert(exit-chat))
)


;Lease-Rent-Rules
(defrule rent-query
    (issue rent)
    =>
    (printout t "Is the rent value specified?" crlf)

    (printout t "1. Yes." crlf)
    (printout t "2. No." crlf)
    (printout t "3. Yes, But not in cash." crlf)

    (printout t "Choice : " )
    (bind ?rent-specified (read))
    (printout t "" crlf)

    (if (= ?rent-specified 1)
        then
            (assert(rent-state specified))
        else
            (if (= ?rent-specified 2)
            then
                (assert(rent-state unspecified))
            else
                (assert(rent-state specified-not-cash))

            )
    )
)


(defrule rent-not-cash
    (rent-state specified-not-cash)
    =>
    (printout t "Don't worry, there's no issue." crlf)
    (printout t "Article 561: Rent may be in cash or in any other form of advance payment." crlf)
    (assert(exit-chat))

)


(defrule rent-specified-rule
    (rent-state specified)
    =>
    (printout t "Don't worry, There's no problem in contract." crlf)
    (assert(exit-chat))

)

(defrule rent-unspecified-rule
    (rent-state unspecified)
    =>
    (printout t "Article 562 : Rent amount is to be considered as per the market rate if not specified. ()" crlf)
    (assert(exit-chat))
)


(defrule exit-rule
    (exit-chat)
    =>
    (printout t "----------------------------------------------" crlf)
    (printout t "I hope i was helpful to you. Don't hesitate to ask anymore questions." crlf)
    
)

