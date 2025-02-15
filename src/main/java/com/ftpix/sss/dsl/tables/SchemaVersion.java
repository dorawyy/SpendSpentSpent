/*
 * This file is generated by jOOQ.
 */
package com.ftpix.sss.dsl.tables;


import com.ftpix.sss.dsl.Keys;
import com.ftpix.sss.dsl.SSS;
import com.ftpix.sss.dsl.tables.records.SchemaVersionRecord;

import org.jooq.Field;
import org.jooq.ForeignKey;
import org.jooq.Identity;
import org.jooq.Name;
import org.jooq.Record;
import org.jooq.Row1;
import org.jooq.Schema;
import org.jooq.Table;
import org.jooq.TableField;
import org.jooq.TableOptions;
import org.jooq.UniqueKey;
import org.jooq.impl.DSL;
import org.jooq.impl.SQLDataType;
import org.jooq.impl.TableImpl;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class SchemaVersion extends TableImpl<SchemaVersionRecord> {

    private static final long serialVersionUID = 1L;

    /**
     * The reference instance of <code>sss.SCHEMA_VERSION</code>
     */
    public static final SchemaVersion SCHEMA_VERSION = new SchemaVersion();

    /**
     * The class holding records for this type
     */
    @Override
    public Class<SchemaVersionRecord> getRecordType() {
        return SchemaVersionRecord.class;
    }

    /**
     * The column <code>sss.SCHEMA_VERSION.CURRENT</code>.
     */
    public final TableField<SchemaVersionRecord, Integer> CURRENT = createField(DSL.name("CURRENT"), SQLDataType.INTEGER.nullable(false).identity(true), this, "");

    private SchemaVersion(Name alias, Table<SchemaVersionRecord> aliased) {
        this(alias, aliased, null);
    }

    private SchemaVersion(Name alias, Table<SchemaVersionRecord> aliased, Field<?>[] parameters) {
        super(alias, null, aliased, parameters, DSL.comment(""), TableOptions.table());
    }

    /**
     * Create an aliased <code>sss.SCHEMA_VERSION</code> table reference
     */
    public SchemaVersion(String alias) {
        this(DSL.name(alias), SCHEMA_VERSION);
    }

    /**
     * Create an aliased <code>sss.SCHEMA_VERSION</code> table reference
     */
    public SchemaVersion(Name alias) {
        this(alias, SCHEMA_VERSION);
    }

    /**
     * Create a <code>sss.SCHEMA_VERSION</code> table reference
     */
    public SchemaVersion() {
        this(DSL.name("SCHEMA_VERSION"), null);
    }

    public <O extends Record> SchemaVersion(Table<O> child, ForeignKey<O, SchemaVersionRecord> key) {
        super(child, key, SCHEMA_VERSION);
    }

    @Override
    public Schema getSchema() {
        return aliased() ? null : SSS.SSS;
    }

    @Override
    public Identity<SchemaVersionRecord, Integer> getIdentity() {
        return (Identity<SchemaVersionRecord, Integer>) super.getIdentity();
    }

    @Override
    public UniqueKey<SchemaVersionRecord> getPrimaryKey() {
        return Keys.KEY_SCHEMA_VERSION_PRIMARY;
    }

    @Override
    public SchemaVersion as(String alias) {
        return new SchemaVersion(DSL.name(alias), this);
    }

    @Override
    public SchemaVersion as(Name alias) {
        return new SchemaVersion(alias, this);
    }

    /**
     * Rename this table
     */
    @Override
    public SchemaVersion rename(String name) {
        return new SchemaVersion(DSL.name(name), null);
    }

    /**
     * Rename this table
     */
    @Override
    public SchemaVersion rename(Name name) {
        return new SchemaVersion(name, null);
    }

    // -------------------------------------------------------------------------
    // Row1 type methods
    // -------------------------------------------------------------------------

    @Override
    public Row1<Integer> fieldsRow() {
        return (Row1) super.fieldsRow();
    }
}
