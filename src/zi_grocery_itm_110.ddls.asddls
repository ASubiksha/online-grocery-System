@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Interface View'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZI_GROCERY_ITM_110 
  as select from zgrocery_itm_110
  /* Parent link - Ithu romba mukkiyam */
  association to parent ZI_GROCERY_HDR_110 as _Header on $projection.OrderUuid = _Header.OrderUuid
{
    key item_uuid             as ItemUuid,
    order_uuid                as OrderUuid,
    item_id                   as ItemId,
    product                   as Product,
    
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quantity                  as Quantity,
    unit                      as Unit,
    
    @Semantics.amount.currencyCode: 'CurrencyCode'
    price                     as Price,
    currency_code             as CurrencyCode,
    
    local_created_by          as LocalCreatedBy,
    local_created_at          as LocalCreatedAt,
    local_last_changed_by     as LocalLastChangedBy,
    local_last_changed_at     as LocalLastChangedAt,
    last_changed_at           as LastChangedAt,
    
    /* Exposure of Association */
    _Header
}
