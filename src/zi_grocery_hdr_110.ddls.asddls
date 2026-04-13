@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Interface View (Root View)'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZI_GROCERY_HDR_110 
  as select from zgrocery_hdr_110
  composition [0..*] of ZI_GROCERY_ITM_110 as _Items
{
    key order_uuid           as OrderUuid,
    order_id                 as OrderId,
    customer_name            as CustomerName,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price              as TotalPrice,
    currency_code            as CurrencyCode,
    overall_status           as OverallStatus,
    
    /* Administrative fields */
    local_created_by         as LocalCreatedBy,
    local_created_at         as LocalCreatedAt,
    local_last_changed_by    as LocalLastChangedBy,
    local_last_changed_at    as LocalLastChangedAt,
    last_changed_at          as LastChangedAt,
    
    /* Associations */
    _Items 
}
